#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int* cover_ip_to_int(char* ip);
int* estimate(int* ip, int* mask);
bool estimate_equal(int* ip, int* mask);

int main(int argc, char** argv)
{
    char* ip1 = (char*)malloc(20 * sizeof(char));
    char* ip2 = (char*)malloc(20 * sizeof(char));
    char* mask = (char*)malloc(20 * sizeof(char));
    printf("please input first ip address:");
    scanf("%s", ip1);
    printf("please input secound ip address:");
    scanf("%s", ip2);
    printf("please input mask ip address:");
    scanf("%s", mask);
    int* ipv1 = cover_ip_to_int(ip1);
    int* ipv2 = cover_ip_to_int(ip2);
    int* m = cover_ip_to_int(mask);
    int* res1 = estimate(ipv1, m);
    int* res2 = estimate(ipv2, m);
    if (estimate_equal(res1, res2) == false) {
        printf("no");
    } else {
        printf("yes");
    }
    return 0;
}

int* cover_ip_to_int(char* ip)
{
    int* nums = (int*)malloc(3 * sizeof(int));
    nums[0] = 0;
    nums[1] = 0;
    nums[2] = 0;
    int i = 0;
    while (ip[i] != '.') {
        nums[0] = nums[0] * 10 + (int)ip[i]-'0';
        i++;
    }
    i++;
    while (ip[i] != '.') {
        nums[1] = nums[1] * 10 + (int)ip[i]-'0';
        i++;
    }
    ++i;
    while (ip[i] != '.') {
        nums[2] = nums[2] * 10 + (int)ip[i]-'0';
        i++;
    }
    return nums;
}

int* estimate(int* ip, int* mask)
{
    int* res = (int*)malloc(3 * sizeof(int));
    res[0] = ip[0] & mask[0];
    res[1] = ip[1] & mask[1];
    res[2] = ip[2] & mask[2];
    return res;
}

bool estimate_equal(int* res1, int* res2)
{
    for (int i = 0; i < 3; ++i) {
        if (res1[i] != res2[i]) return false;
    }
    return true;
}

