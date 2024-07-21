Return-Path: <linux-kernel+bounces-258164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1401793849F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 14:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EDA1F214C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4427F1581E0;
	Sun, 21 Jul 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="H8wxWoji"
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B053BE
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721566264; cv=none; b=RQCwGbcuX4Lo70Wrn0QPLhQ/vAD2C8YCnOc02+2HWlCNBHrwoxc3BRtGsitD4aUzRe/o75Fy84fzJ375NJaHk54yRuKGf8szrVZcuSJ1I2enrHdKJVq5z4TI9MJ+HPUibKqEaywGEbxv6CveFptO3pm6hIzQEdm9MekvNXdL7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721566264; c=relaxed/simple;
	bh=gMdewBxZWv3QMhzWy5G11sv54xsQ2K6k77fNE2Sow48=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FnlWkzqwoR/mNj8bMqqmpaC+3SK7eu2+t5mWA9wpNxVU1wTEGLMQFpRAin2RVXMV1NMYl1fuzKqEqd2MIB2fDcKgokJNQNg/q2fk4PngqLi5z66W6jGrMYxGgq/QXifYB+75wgCYSsX+OEJ8U6hHH3SWzmO8q7FAl1lqPpRBtDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=H8wxWoji; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721566252; x=1721825452;
	bh=gMdewBxZWv3QMhzWy5G11sv54xsQ2K6k77fNE2Sow48=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=H8wxWojiBypAVx5wePOxNArbKxmvdDZs46Ad44HzBou+lKOu6NLEhJxm03yL4RTJW
	 6eaNfH49++rRqYoJam0gOhcFiuuTJX6rLEQpaT5OQOcSu7sHiMDsNc92AjFoZ9JN/u
	 Zp9JcTSD5DFey6+yBcgf/ByeT4T/Db9Xqz7hX5mStG0Sv/jNvRlhOhPIlgWe6zLfwz
	 AF8AF9AruGY0Oze7n7JpqOpcela1Up8g0I2JTTajuPnnxpU5OIepNsIWizzsUmtfHL
	 EapU8y8ZPvapnMN79aUaZKfnI4sdqHQdyRes/Mq7patXxCO6hmD50ej0OklI7bBncA
	 x+5/E3XbXbzJw==
Date: Sun, 21 Jul 2024 12:50:48 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: List of InfoComm Technology (ICT) Projects/Jobs/Tasks/Assignments Completed by Teo En Ming between 15 Jun 2020 and 5 Jul 2024 (spanning 4 years)
Message-ID: <O9U71OJDAuPgGM6gq_LeZxw4OJY_Q_QsD1S_WA3LfHfeOnkr1diIjk6Pm0E1kacBHDlnvu_1ic5MX33cQDpRfYdHB7yPcCJ5HWWWsMiL55g=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: da22b0b83f30e087ab3c5c1758e22beac18070d6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: List of InfoComm Technology (ICT) Projects/Jobs/Tasks/Assignments =
Completed by Teo En Ming between 15 Jun 2020 and 5 Jul 2024 (spanning 4 yea=
rs)

Good day from Singapore,

Section A: Teo En Ming's Projects, Mini Projects, Jobs, Tasks, Assignments
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Company #
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Reconfiguration of Fortigate 201F firewall due to major VLAN changes (using=
 SD-WAN)

I have successfully installed Godaddy Wildcard SSL Certificate for 2 years =
in Fortigate 201F firewall on 20 Oct 2022 Thursday

I have 100% successfully installed Godaddy Wildcard SSL certificate in UniF=
i Cloud Key Gen 2 Plus on 26 Oct 2022 Wednesday from 5 PM to 6 PM

I have successfully installed Godaddy Wildcard SSL certificate in 9 units o=
f Hikvision DS-K1TA70MI-T / DS-K1T341AMF Face Recognition Terminal Door Acc=
ess Systems on 27 Oct 2022 Thursday

Successfully added Jumpcloud LDAP server in Fortigate 201F firewall on 8 No=
v 2022 Tues

I have successfully instructed client to connect LAN cable from patch panel=
 port D062 to port 7 on the Fortigate 201F firewall on 29 Apr 2024 Mon, now=
 both Hikvision door face scanners 192.168.150.4 and 192.168.150.5 are acce=
ssible (web interface).

Company A1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup about 10 laptops there + always go there for network and PBX/IP phone=
 troubleshooting

Company A2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Configured Aztech DSL1015EW(S) Wireless Router as spare

Company A3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully reconfigured Fortigate 80F firewall remotely for a comp=
any at Goldhill Plaza on 7 May 2024 Tuesday after my colleague Dennis facto=
ry resets it onsite. Another reason for the reconfiguration is because the =
HPE MSR900 router has failed.

Company A4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have configured UniFi Cloud Key Gen2 Plus, USW-16-PoE network switch, and=
 U6-Pro access points for a dental company at 111 Somerset on 21 May 2024 T=
uesday but not deployed yet

I have successfully configured UniFi Cloud Key Gen2 Plus, USW-16-PoE networ=
k switch, and U6-Pro access points for a dental company at 111 Somerset on =
21 May 2024 Tuesday, and my colleague Kenneth has deployed all the devices =
at customer site on 23 May 2024 Thursday

Company B1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully configured SD-WAN in Fortigate 200F firewall for a wire=
less router distributor in Singapore on 10 May 2024 Friday 5.45 PM to 9.00 =
PM

Company B2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Added a domain to Active Directory

Company B3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Migration of standalone M1 network switch and 7 wireless access points to t=
heir existing infrastructure
Relocate their M1 ONT to WAN2 on Fortigate firewall
Configure Fortigate 90D firewall for WAN redundancy
Assist in setting up Fuji Xerox printer with Fujifilm vendor

DHCP server run out of IP addresses, solved the problem by expanding DHCP p=
ool and reducing lease time from 8 hours to 4 hours

I have successfully configured Aruba 7010 wireless controller, Aruba 6000 4=
8G CL4 4SFP network switch and Fortigate 200F firewall with VLANs 1 and 99 =
(Guest Wi-Fi) and VLAN trunks for a food company at Elementum building on 4=
 Apr 2024 Thursday

I have solved the problem where office LAN and Wi-Fi users could not access=
 a German website by disabling an erroneous static route in the Fortigate 2=
00F firewall on 12 Apr 2024 Friday

Company B4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully migrated Fortigate 90D firewall to Fortigate 60F firewa=
ll for a precision engineering company at Ang Mo Kio Industrial Park 2A on =
18 May 2023 Thursday

I have successfully solved Linkus softphone no audio issue during calls for=
 Yeastar S20 PBX behind Fortigate 60F firewall for a German company in Sing=
apore on 7 Oct 2023 Sat 3.00 AM

Company B5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully installed new SSL certificate in Microsoft Exchange ser=
ver 2013 CU 23 for a hotel chain in Indonesia on 25 Sep 2023 Monday

Company B6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Upgraded firmware for various network devices:

Cisco SG550X-48P network switch (successful)
Cisco SG300-28P network switch (successful)
Asus RT-AC68U wireless router (successful)
Aruba 7005 wireless controller (unsuccessful)
UniFi USW-48P-750 network switch (successful)
Sophos XG210 firewall (successful)

Setup PRTG Network Monitor to monitor the bandwidth usage of Sophos XG210 F=
irewall

Enable SNMP and add sensors in PRTG Network Monitor for Cisco SG550X-48MP N=
etwork Switch

Enable SNMPV3 and add sensors in PRTG Network Monitor for Aruba 7005 Wirele=
ss Controller

I have successfully enabled SNMP and add sensor in PRTG Network Monitor for=
 CalnCall SBC25 PBX on 5 Apr 2022 Tuesday

I have successfully exported configuration of UniFi US-48-750W network swit=
ch on 25 Apr 2022 Monday

I have successfully upgraded the firmware of Cisco SG550X-48MP network swit=
ch from version 2.5.5.47 to version 2.5.8.15 on 25 Apr 2022 Mon

I have successfully upgraded firmware of Aruba 7005 wireless controller fro=
m version 6.5.4.23 to 8.9.0.3, perform factory reset, and successfully setu=
p and configured ArubaOS 8.9.0.3 for Aruba 7005 wireless controller from sc=
ratch on 22 Sep 2022 Thursday from 1 PM to 3 PM (2 hrs)

I have successfully re-deployed PRTG Network Monitor on a new server, added=
 network devices and created sensors for these network devices on 9 Mar 202=
3 Thurs

I have successfully upgraded the firmware of Ruckus ICX 7150 Campus Network=
 Switch from version 10 Dec 2021 to version 11 Apr 2023 for a company at No=
vena Medical Specialist Center Singapore on 8 Jun 2023 Thursday

I have successfully upgraded Ruckus R320 wireless access point to latest Un=
leashed firmware and configured WLAN from scratch and got everything workin=
g on 23 June 2023 Friday

Transferred running-config from Ruckus ICX 7150 network switch to TFTP serv=
er on 3 Jul 2023 Mon

I have successfully upgraded the firmware of Ruckus ICX-7150 24-port networ=
k switch using TFTP for an organization at Novena Medical Specialist Centre=
 on 17 Jul 2023 Monday.

I have successfully configured brand new replacement slave/passive Sophos X=
GS2100 firewall and HA cluster for both units of Sophos XGS2100 firewalls w=
ith successful failover testing for a medical organization at Novena Specia=
list Center on 24 Nov 2023 Friday 12 noon to 3 PM

I have successfully configured MFA 2FA for SSL VPN in Sophos XGS2100 Firewa=
ll for a medical company at Novena Specialist Center on 25 Apr 2024 Thursda=
y

I have successfully changed Ruckus R320 wireless access point from VLAN 1 t=
o VLAN 20 for a medical organization at Novena Specialist Center on 28 Jun =
2024 Friday

Company C1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully migrated from old Fortigate 90D firewall to brand new F=
ortigate 80F firewall for a F&B chain in Singapore on 14 Mar 2023 Tuesday

Company C2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup 2 units of Dell Latitude 5424 Rugged Laptops with Windows 7 Pro (need=
s hacking)

Company D
=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully installed new SSL certificate on Exchange 2010 email se=
rver for a dental company in Singapore on 8 Jan 2024 Mon

I have successfully installed and configured 3rd party open source DKIM sig=
ner on Exchange 2010 email server for a dental company on 11 Jan 2024 Thurs=
day

Summary of the tasks I have done for client, in sequence, spending many hou=
rs

[1] Installed and configured 3rd party open source DKIM Signer in Exchange =
2010 email server

[2] Changed PUBLIC IP address of Exchange 2010 email server by modifying Po=
rt Forwarding and Source NAT settings in Draytek Router and also changing M=
X and numerous A DNS records

[3] Created new send connector in Exchange 2010 email server to use SMART H=
OST, as instructed by boss

[4] Created DKIM and DMARC records.

[5] Modified SPF record.

Company E1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully migrated UDM Pro firewall to Fortigate 80F firewall for=
 a company at Bedok Food City on 26 May 2023 Friday

Company E2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Configure Fortigate 80C firewall and assist in their office relocation

Company E3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Created user shared folders in Windows Server Domain Controller and disable=
d inheritance in user shared folders. Configured Cobian Backup 11 Gravity t=
o backup all users to the user shared folders on the DC.

Company E4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Assisted Shaun to add DNS records in CloudFlare DNS Management on 26 Jun 20=
23 Monday

Company E5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully mounted iSCSI Targets from Synology NAS in Debian 11 Li=
nux server for a construction company in Singapore on 10 Feb 2023 Fri

Company F1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup Fortigate 80F firewall
Convert Asus RT-AX88U wireless router to access point

Company F2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Replace 2 harddisks in Drobo NAS (assisted by Jana)
Configure their Fortigate 90D firewall for their 2nd internet line (SPTEL I=
SP) (WAN2)
Setup Aruba Instant ON AP22 access point
Upgrade iMac for their boss from macOS High Sierra to macOS Monterey
Erase and reinstall macOS

I have configured SD-WAN in Fortigate 101F firewall for a company at Balmor=
al Plaza on 15 May 2024 Wed but not tested working yet

I have successfully configured SD-WAN in Fortigate 101F firewall for a comp=
any at Balmoral Plaza on 16 May 2024 Thursday, without the IPsec site to si=
te VPN tunnel

I have successfully configured SD-WAN in Fortigate 101F firewall for a comp=
any at Balmoral Plaza on 17 May 2024 Friday, TOGETHER with IPsec site-to-si=
te VPN tunnel configured successfully as well

Company F3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have identified and resolved IP address conflicts and solved SAP server u=
nreachable over the Fortigate site to site IPsec VPN tunnel on 3 Nov 2022 T=
hursday.

I have configured new Fortigate 60F firewall on 25 Apr 2023 Tuesday.

I have successfully migrated Fortigate 90D firewall to Fortigate 60F firewa=
ll for a customer near Stevens MRT on 28 Apr 2023 Friday

Company F4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Attended to severe water leakage in their server room due to extremely heav=
y rain over 3 days

I have successfully migrated Veritas Backup Exec Server 21.1 from Old Serve=
r to New Server using the Manual method, instead of using Backup Exec Migra=
tion Assistant, for an engineering company that previously had water leakag=
e in their server room, on 18 July 2023 Tuesday

Company F5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup Fortigate 60F firewall (with Jordon)

Company F6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully migrated ASUS RT-AX56U wireless router to Fortigate 60F=
 firewall for a company at Royal Group Building Raffles Place on 25 May 202=
3 Thursday

Company G (onsite with Shaun)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Relocate existing infrastructure to new 27U server rack
Setup UniFi 24port 250W POE switch with UniFi Network Controller
Setup Grandstream GWN7000 wireless controller
Setup 2x Grandstream GWN7630 access points
Install and configure Acronis Cyber Backup 15 Server Standard

Company H
=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully migrated Singtel Mesh Router (SME) to Fortigate 60F for=
 a medical company at Yishun Industrial Park A on 5 May 2023 Friday

Company J1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup SSL VPN in Cisco ASA 5506-X Firewall with Duo
Renew and install SSL certificates for Cisco ASA firewall SSL VPN
Setup Fortigate 60F firewall with SSL VPN and Duo (with Jordon)
Setup no-ip auto renewal script (Python programming involved) in Debian Lin=
ux virtual machine

Company J2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Formatted Fortigate 80E firewall, installed latest firmware image version 7=
.0.3 and restored from latest config file backup

Company J3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully setup and configured Tp-link Archer AX72 AX5400 WI-FI 6=
 Wireless Router on 29 Aug 2022 Mon

Company K1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully migrated Fortigate 60E firewall to Fortigate 60F firewa=
ll for a company at Link @ AMK on 24 Apr 2023 Mon, using export and import =
configuration

Company K2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully switched from WAN1 to WAN2, modified Virtual IPs and fi=
rewall rules, and reconfigured IPsec site to site VPN tunnel in Fortigate 8=
0F firewall for a company at AMK Techplace 2 on 4 Jun 2024 Tue

Company K3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully switched from Singtel ISP to StarHub ISP PPPoE (WAN1) i=
n Fortigate 60E firewall for a TCM company at Shun Li Industrial Park on 27=
 Mar 2024 Wed

I have converted Linksys Velop MX2000 Wi-Fi router to Bridged Mode for a TC=
M company at Shun Li Industrial Park on 27 Mar 2024 Wed

Company M
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup 1x Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch (GUI)
Setup HPE Aruba 2530-24 network switch (Command Line Only)

I have successfully completed disaster recovery for an engineering company =
in Woodlands Singapore using Veritas Backup Exec 22 Server on 23 Feb 2023 T=
hursday, initial data restore operation started on 21 Feb 2023 Tuesday, inc=
ludes setting up new Windows Server 2022 Standard Domain Controller

Migrate from Fortigate 60D to Fortigate 60F - this project has been reassig=
ned to Dennis from New York City by Kok Keong. Teo En Ming will not be doin=
g this project any more.

Company N
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Discovered that Windows Server 2016 Datacenter (aka Windows Terminal Server=
) EC2 instance in Amazon AWS Cloud was shutdown at 1.35 PM on 7 July 2023 F=
riday. I have powered it on again at about 3.34 PM. The EC2 instance has 16=
 core Intel Xeon Platinum processor with 64 GB of RAM (I think). There is a=
 total of 4 EC2 instances, with 3 running Windows Server and the last one r=
unning Linux/UNIX. The last EC2 instance is a SAP HANA Database running on =
SLES.

Company O1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have configured brand new Fortigate 200F firewall for a wine company in S=
ingapore on 13 Apr 2023 Thu, pending swing over on 29 Apr 2023 Sat

Company O2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully configured and deployed UniFi Cloud Key Gen 2 Plus for =
a mining company at SingPost Centre on 23 Mar 2024 Saturday

Company P1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully added secondary email domain in Google Workspace for an=
 engineering company at Goldhill Plaza on 8 Jan 2024 Mon

I have successfully added SPF and DKIM DNS records for Google Workspace for=
 an engineering company at Goldhill Plaza on 9 Jan 2024 Tue

I have successfully performed email migration (Google-hosted) from old doma=
in name to new domain name for an engineering company at Goldhill Plaza on =
11 Jan 2024 Thursday

Company P2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Discovered mistakes/misconfiguration in network interfaces and made correct=
ions to the new Fortigate 101F firewall on 20 Apr 2023 Thu. Originally conf=
igured by Seng Jian and Danial. Haven't swing over yet.

I have made extensive corrections to the new Fortigate 101F firewall (due t=
o misconfiguration) and managed to get it up and operational for a Spanish =
company on 2 May 2023 Tue

Company R
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Solved Sangoma FreePBX Asterisk VoIP IP PBX SIP ISDN Phone Line is Down Iss=
ue

Regarding Sangoma FreePBX Phone System 60 hardware appliance, I have assist=
ed to boot Red Hat SHMZ 6.6 OS into Single User Mode and repair the ext4 fi=
lesystem on /dev/sda2 using fsck on 5 Jul 2023 Wed

I have successfully identified short circuit on cables connected to switch =
ports gi1 and gi2 on Cisco SG300-28PP network switch using "test cable-diag=
nostics tdr interface" CLI command for a company at High Street Center on 2=
1 Jun 2024 Friday afternoon

Company S1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully setup the 1st Fortigate 101F firewall for a nursing hom=
e at Serangoon Singapore on 16 Mar 2023 Thursday

I have successfully configured High Availability (HA) cluster and SD-WAN fo=
r 2 Fortigate 101F firewalls for a nursing home at Serangoon on 9 May 2023 =
Tue, using 3 Aruba Instant On 1830 8G network switches

Company S2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully migrated Fortigate 100D firewall to Fortigate 200F fire=
wall for a school at Suntec City Tower 2 on 24 Jun 2023 Saturday

Company S3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Disabled Duo 2FA in Windows Server 2012

Reset password for 3 admin users (with 2FA) in Fortigate 200D firewall

Install Cisco Duo Security 2FA MFA in Windows Server using Active Directory=
 Group Policy Objects GPO (not successful as of 29 Apr 2022 Fri)

Install Cisco Duo Security 2FA MFA in Windows Server using Active Directory=
 Group Policy Objects GPO (SUCCESSFUL as of 4 May 2022 Wed)

Aruba Clearpass Policy Manager shows users cannot connect to Wi-Fi: login f=
ailed and time out to RADIUS server, solved the problem by rebooting all 21=
 Aruba wireless access points

I have successfully installed RADIUS/EAP SSL certificate in Aruba ClearPass=
 Policy Manager for a company at Upper Jurong Road on 25 Mar 2024 Monday

Problem: Laptop cannot connect to Aruba ClearPass Policy Manager with Error=
 Code 216.
Reason: Domain Controller rejects laptop. Access is denied.
Solution: I have advised user to re-image his laptop on 14 May 2024 Tue. Pr=
oblem solved.

I have successfully installed and configured Cisco Duo 2FA MFA Authenticati=
on for 3 Windows Servers for a company at Upper Jurong Road on 27 May 2024 =
Monday

Company S4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully setup Fortigate 101F firewall for an engineering compan=
y at Penjuru Place Singapore on 8 Mar 2023 Wed

Company S5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup new server (Windows Server 2019 Standard) as 2nd domain controller
Robocopy shared folders from old server to new server
Install and configure StorageCraft ShadowProtect SPX 7.0.2 in their new ser=
ver

Company S6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Upgraded MacBook Pro of Irene Ng from macOS El Capitan to macOS Big Sur

Company S7
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have started migrating Fortigate 100D to Fortigate 101F for an electronic=
s company at New Industrial Road on 11 May 2023 Thu

I have successfully migrated Fortigate 100D to Fortigate 101F for an electr=
onics company at New Industrial Road on 15 May 2023 Mon

Successfully configured portforwarding to SAP Server on SAP Development ser=
ver by adding 1 IP pool with associated firewall rule, making adjustmeents =
to 4 Virtual IPs, and added 4 portforwarding rules on Fortigate firewall on=
 19 Sep 2023 Tue

Internal network and servers cannot access their new company website with n=
ew ip address. Problem solved by restarting Windows DNS Server in Domain Co=
ntroller 192.168.8.11. 6 May 2024 Monday.

Company T1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have configured new Fortigate 80F firewall on 26 Apr 2023 Wed

I have successfully migrated Fortigate 90D firewall to Fortigate 80F firewa=
ll for a company at Pioneer Road on 3 May 2023 Wed

Company T2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Renew and install SSL Certificates for Webmin, Apache webserver, Postfix an=
d Dovecot

Company T3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup 2x CentOS 7.9 Linux Servers for their cPanel (with Danial)

I have successfully cloned CentOS 7.9 Linux Server with cPanel web hosting =
control panel to Synology NAS using Clonezilla for a construction company i=
n Singapore on 23 Jan 2024 Tue

Company T4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Migrate WordPress Website on Apache Web Server from 32-bit CentOS Linux 6.3=
 to 64-bit CentOS Linux 8.2 (2004)
Setup Synology RackStation RS1221+ NAS (with David Aw)
Setup 20 laptops and desktops there
Generated CSR for Exchange Server, Signed CSR using AD CS, and installed SS=
L certificate in Exchange server

I have successfully installed datto RMM Linux Agent on CentOS 8 Linux Serve=
r on 11 Oct 2023 Wednesday

Company T5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Installed SSL certificate in PaperCut Application Server

I have successfully installed SSL certificate for PaperCut Application Serv=
er for a company at Chinatown Singapore on 2 May 2023 Tuesday

I have successfully migrated old MacBook Air to new MacBook Air (macOS Vent=
ura 13.0) using Migration Assistant for user Gattie at a company in Chinato=
wn on 11 May 2023 Thu

Troubleshooting why Grandstream UCM6510 PBX cannot be pinged and Web UI can=
not be accessed on 6 Jun 2023 Tue, no conclusion yet

Company V1 (onsite with Shaun)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Setup Fortigate 100F firewall
Setup Synology DS220+ NAS
Reconfigure Cisco C1111-4P Router from NAT mode to non-NAT mode (perform pa=
ssword reset first)

I have successfully setup Synology DS220+ NAS for a company in Tuas, Singap=
ore on 19 Aug 2022 Friday.
This also includes configuring and enabling SSL VPN in the Fortigate firewa=
ll and its related firewall policy.

Successfully configured Bypass Authentication in Exchange server Receive Co=
nnector to send email alerts from IBM Server IMM on 10 Nov 2022 Thu

I have successfully configured SD-WAN in Fortigate 100F firewall for an eng=
ineering company at Tuas Crescent which has both Singtel and SPtel ISPs (WA=
N1 and WAN2) on 26 Mar 2024 Tuesday

Company V2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Migrate from old Fortigate 60F firewall to brand new Fortigate 80F firewall

Company V3 (law firm)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup TP-Link AC1900 (Archer C80) Wireless Router in Access Point mode

I have solved the problem of IPsec site-to-site VPN tunnel going down betwe=
en distant Fortigate firewalls for a law firm in Singapore on 9 Mar 2023 Th=
urs

Started configuring Fortigate 200F firewall on 20 Apr 2023 Thu, still work =
in progress as of 21 Apr 2023 Friday.

I have successfully migrated Fortigate 200D firewall to Fortigate 200F fire=
wall for a law firm at Bugis on 6 May 2023 Saturday

I have successfully restored Veeam backup of Windows Server 2008 R2 Standar=
d 64-bit in VMware Workstation 17 Pro in IBM System x3650 M4 server with Wi=
ndows Server 2016 Standard for a law firm in Singapore on 19 Sep 2023 Tuesd=
ay

RAID 1 virtual drive is missing. A Foreign Configuration was created by the=
 RAID controller. I have imported the Foreign Configuration and solved the =
problem for the law firm. Windows Server is able to start successfully. 8 J=
an 2024 Monday.

I have successfully created RAID 1 array with 2 pcs of replacement 300 GB S=
AS harddisks, installed and configured Samba as a File Server on Debian 11 =
Linux Server in Data Center, and performed data recovery using Veeam Recove=
ry Media accessing the File Server for a law firm in Singapore on 24 Jan 20=
24 Wed

I have successfully installed new self-signed SSL certificate on Suprema Bi=
oStar 2 Door Access System for a law firm in Singapore on 7 Mar 2024 Thursd=
ay

Company V4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup 2x CentOS 7.9 Linux Servers with NIC bonding for their data center (w=
ith Jun Cheng)
Setup Synology Rackstation RS820+ NAS

Company W1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Configure Cisco Catalyst 1000 network switch model Cisco-C1000-8P-2G-L (usi=
ng Command Line)
Setup Grandstream GWN7000 wireless controller
Setup 6x Grandstream GWN7630 wireless access points

Company W2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have successfully generated CSR using Exchange Management Shell cmdlet, s=
igned the CSR using Windows Server Certification Authority and imported the=
 generated certificate into Microsoft Exchange for a German company in Sing=
apore on 19 Mar 2024 Tuesday

Company W3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have started and completed configuring new Fortigate 80F firewall for a t=
ransport company at Tuas Ave 9 on the same day of 12 May 2023 Friday

I have successfully migrated Fortigate 100D firewall to Fortigate 80F firew=
all for a logistics company at Tuas Ave 9 on 19 May 2023 Friday

Company Y
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have provided advice to my colleague Yuhaimi concerning the Supermicro GP=
U SuperServer SYS-821GE-TNHR with Red Hat Enterprise Linux 9.3 installed in=
 the data center on 11 Jun 2024 Tuesday. Failed to open \EFI\redhat\grubx64=
.efi - Not Found

Forgot the company name
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Configure Veeam Backup

For several companies
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Install Ubuntu Linux virtual machine, install nmap, and download nmap nse p=
lugins to scan for log4j security vulnerabilities.

Fortigate Firewalls Hardening Project (based on hardening template from bos=
s)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Milestone 1: I have completed hardening 30 Fortigate firewalls as of 16 Jun=
 2023 Friday

I have completed hardening 31 Fortigate firewalls AFTER 16 Jun 2023 Friday

=3D=3D=3DEOF1=3D=3D=3D

Section B: List of companies for which Teo En Ming has *configured* Fortiga=
te firewalls (Update 5 Jul 2024)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

[01] Company V - migrate from IPCOP Linux firewall to Fortigate 100F - alre=
ady deployed on 5 Nov 2021 (based on config backup date)

[02] Company J - migrate from Cisco ASA 5506-X to Fortigate 60F - already d=
eployed on 5 Jul 2021 (based on registration date)

[03] Company F - migrate from ??? to Fortigate 60F - already deployed on 22=
 Jul 2021 (based on config backup date)

[04] Company F - migrate from Asus RT-AX88U wireless router to Fortigate 80=
F - already deployed on 3 Jan 2021 (according to Helen Lim)

[05] Company V - migrate from Fortigate 60F to Fortigate 80F - already depl=
oyed on 21 Jan 2022 (based on config backup date) (export and import config=
uration)

[06] Company S - migrate from Asus RT-AX88U wireless router to Fortigate 10=
1F - already deployed on 8 Mar 2023 Wed

[07] Company C - migrate from Fortigate 90D to Fortigate 80F - already depl=
oyed on 14 Mar 2023 Tues

[08] Company S - migrate from D-link DIR-868L wireless router to Fortigate =
101F - already deployed on 16 Mar 2023 Thu (1st out of 2 units)

I have successfully configured High Availability (HA) cluster and SD-WAN fo=
r 2 Fortigate 101F firewalls for a nursing home at Serangoon on 9 May 2023 =
Tue, using 3 Aruba Instant On 1830 8G network switches

All outstanding issues with the HA Cluster, SD-WAN and failover have FINALL=
Y been resolved with my onsite visit on 30 Jun 2023 Friday.

[09] Company O - migrate from Fortigate 200D to Fortigate 200F - Danial ons=
ite on 13 Apr 2023 Thu, postponed 1st time to 29 Apr 2023 Sat, postponed 2n=
d time to 27 May 2023 Sat, postponed 3rd time to 3 Jun 2023 Sat, already de=
ployed on 3 Jun 2023 Saturday

Kok Keong and Dennis went onsite on 3 Jun 2023 Saturday to deploy the new f=
irewall (FINALLY after being postponed 3 times).
Kok Keong discovered that Port 23 (WAN1) on the new firewall is a SFP port.

When I configured the new Fortigate 200F firewall from scratch on 13 Apr 20=
23, I did not realize that port 23 (WAN1) is a SFP port. This is because I =
did not have the chance to see the physical firewall for myself. I have onl=
y looked at the PHOTO of the new Fortigate 200F firewall appliance briefly.

The following are the FEW changes that Kok Keong has made as of 3 Jun 2023 =
Sat:-

Kok Keong changed WAN1 from Port 23 to Port 15 on the new firewall, did not=
 configure WAN2, removed SD-WAN configuration and finally changed Port 23 t=
o Port 15 in firewall rules concerning/relating to WAN1 only.

The new Fortigate 200F firewall went fully operational on 3 Jun 2023 Sat.

[10] Company K - migrate from Fortigate 60E to Fortigate 60F - already depl=
oyed on 24 Apr 2023 Mon (export and import configuration)

[11] Company V (law firm) - migrate from Fortigate 200D to Fortigate 200F -=
 already deployed on 6 May 2023 Saturday

[12] Company F - migrate from Fortigate 90D to Fortigate 60F - already depl=
oyed on 28 Apr 2023 Friday

[13] Company T - migrate from Fortigate 90D to Fortigate 80F - already depl=
oyed on 3 May 2023 Wed

[14] Company H - migrate from Singtel Mesh Router (SME) to Fortigate 60F - =
already deployed on 5 May 2023 Friday

[15] Company S - migrate from Fortigate 100D to Fortigate 101F - already de=
ployed on 15 May 2023 Monday

[16] Company W - migrate from Fortigate 100D to Fortigate 80F - already dep=
loyed on 19 May 2023 Friday

[17] Company B - migrate from Fortigate 90D to Fortigate 60F - already depl=
oyed on 18 May 2023 Thursday

[18] Company F - migrate from ASUS RT-AX56U wireless router to Fortigate 60=
F - already deployed on 25 May 2023 Thursday

[19] Company E - migrate from UDM Pro firewall to Fortigate 80F - already d=
eployed on 26 May 2023 Friday

[20] Company S - migrate from 2 units of Fortigate 100D to 2 units of Forti=
gate 200F (1 active, 1 spare) - 1st day of setup on 19 June 2023 Monday, 2n=
d day of setup on 20 Jun 2023 Tuesday, already deployed on 24 Jun 2023 Satu=
rday

[21] Company J - TO BE CONFIRMED

[22] Company T (law firm) - migrate from 2 units of Sophos SG310 to 2 units=
 of Fortigate 200F in HA cluster mode - TO BE CONFIRMED

=3D=3D=3DEOF2=3D=3D=3D

Section C: List of Firewall Migration Projects *NOT* Handled by Teo En Ming
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[01] Company P - configured by Seng Jian and Danial. Corrections were made =
by Teo En Ming and the firewall went operational.

[02] Company T - configured by Danial and Kok Keong. Teo En Ming is NOT inv=
olved in this project at all.

[03] Company M - migrate from Fortigate 60D to Fortigate 60F - handled by D=
ennis. Teo En Ming is NOT involved in this project at all.

[04] Company S - transfer of ownership of Fortigate 81E from one vendor to =
owner, no new Fortigate firewall purchased - NOTHING TO DO AT ALL

[05] Company I - migrate from Fortigate 90D to Fortigate 60F - handled by D=
ennis. Teo En Ming is NOT involved in this project at all.

[06] Company G - migrate from Fortigate 60D to Fortigate 60F - handled by D=
ennis. Deployment date not recorded. Teo En Ming is NOT involved at all.

[07] Company T - migrate from Fortigate 90D to Fortigate 80F - Handled by D=
ennis. Deployed on 25 Aug 2023 Friday. Teo En Ming is NOT involved at all.

[08] Company T - migrate from Fortigate 90E to Fortigate 101F - handled by =
Kok Keong, Yuhaimi understudy only. Deployed on 9 Sep 2023 Sat. Teo En Ming=
 is NOT involved at all.

[09] Company M - setup Fortigate 80F - handled by Danial. Teo En Ming is NO=
T involved at all.

[10] Company C - setup Fortigate 101F firewall - handled by Danial.

[11] Company H - setup Fortigate 40F firewall - handled by Kelvin Lai.

[12] Company A - setup Fortigate 60F firewall on 6 Jun 2024 Thursday - hand=
led by Kenneth from Malaysia

[13] Company W - Dennis to deploy Fortigate 40F firewall on 26 Jun 2024 Wed=
 - handled by Dennis

[14] Company V warehouse - Kenneth Tan to deploy Fortigate 80F firewall on =
5 July 2024 Friday - handled by Kenneth Tan


=3D=3D=3DEOF3=3D=3D=3D

Section D: Teo En Ming Provide Training/Guidance to Colleagues
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[01] Company M - I have provided guidance to Danial on setting up Fortigate=
 80F firewall for a precision engineering company in Singapore on 26 Sep 20=
23 Tue

[02] Company C - I have provided guidance to Danial on setting up Fortigate=
 101F firewall for a precision engineering company in Singapore on 20 Oct 2=
023 Friday. I have also successfully created IPsec site to site VPN tunnel =
between Company C and Company M Fortigate firewalls using the VPN Wizard. I=
t is not necessary to convert to a Custom tunnel.

[03] Company H - Teo En Ming provided guidance to Danial on setting up Fort=
igate 100F firewall on 19 Jan 2024 Friday

=3D=3D=3DEOF4=3D=3D=3D

Section E: List of Fortigate SD-WAN Configured by Teo En Ming
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[1] Company S

[2] Company V

[3] Company B

[4] Company F

=3D=3D=3DEOF5=3D=3D=3D

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
IT Consultant
Republic of Singapore
14 July 2024 Sunday 10.06 PM Singapore Time






