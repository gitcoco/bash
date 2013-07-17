#!/usr/bin/awk -f
#function:calculate the worktime
#worktime start calculate from 08:00,12:00-13:30 and 17:30-18:00 is the resttime#,not calculate in the worktime 
#worktime list's filename is calculate-worktime.txt
    function atoi(s){split(s,a,":");return a[1]*3600+a[2]*60+a[3]}
    function itoa(n){i=sprintf("%02d:%02d:%02d",int(n/3600),int(n%3600/60),n%60);return i}

    BEGIN{h=3600;start=8*h;mid=12*h;midend=13.5*h;end=17.5*h;ot=18*h}
    {
        j=atoi($2);
        k=atoi($3);
        if(j<start)
            j=start;
        if(k>=mid && k<=midend){
            k=mid;
            sum+=k-j;
            print itoa(j),itoa(k),itoa(k-j);
        }

	if(k>=end && k<=ot){
            k=end;
            sum+=k-j-1.5*h;
            print itoa(j),itoa(k),itoa(k-j-1.5*h);
        }
        if(k>ot){
            sum+=k-j-1.5*h-0.5*h;
            print itoa(j),itoa(k),itoa(k-j-1.5*h-0.5*h);
        }
    }
    END{
        print "avg: "itoa(int(sum/NR))
    }
