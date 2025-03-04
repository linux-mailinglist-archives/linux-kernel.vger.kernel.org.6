Return-Path: <linux-kernel+bounces-543128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D55A4D1CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738A23AB4F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91518A6D3;
	Tue,  4 Mar 2025 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="tLkg20oO"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81C13AC1;
	Tue,  4 Mar 2025 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741056183; cv=fail; b=chFsTm/+X5LkWAzSNMhwTHpPYl8CuDCle8qGFKJIo4MMMklVNLVlbUdnerbPgCh4teD9A73emZk2S09iWaIhZ97vU3OU2JHVOWjZajd1yb2+9ZaFMHhIxyGMLiuCuE9ay5WzHDiwDz4zaeIbFERThQUr1NCpSbcKRJv2AcYPVeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741056183; c=relaxed/simple;
	bh=o4eL5E36ENtDxKLH0Pnmp11A+NtqvtY7mDfMFExo4/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h/n5mnAQ+yTtBWkpTJd3rGTkcFt3Z8Qr3h9GqPvo+iTkGHSfRjgRkkogmCfs29nAIl+ZU91Xb7StdFLAobf7MqnqB8wYXY7hIRD9Z6H2aVwOzzvAUyHABlaDzJ0WK5xUSIBa5H+c9qM7iUs7h+rv5OgjOIX4mLFNGRp6QkuVfpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=tLkg20oO; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NUE8C020220;
	Mon, 3 Mar 2025 18:17:20 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 455p5c8a2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 18:17:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJjALZc/Pn0dXjRD6RFO1iOfdjgIVJaijHWxyk1gUyo2Qko5EmWbSUztAnBjQzL6/fL9Cw23tck8//ycx/y5l9Er7zaTwMaN/TLNYV5w3f9bBEyirXItksc6gK0BVV+KfPzNu0dWA5hqtMfPE7vKnD3UeyrDZOuQSEN3Oib0yHGRctjDZlPQerBSywLoYizeC/v+9uTCaawtE1wBxhWt9cQMbxp3aIgIW7QAqhwl+PH97jM/3FmMvbr43LF6fc2kmEVXfMvOi/hq1A7kmyJ6XVeDIVgSQMMX8uZcWI38EQKrcs9fFA2BgNeqDhnVzb1Tc58wt+4WpFMQuf/eflqI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4eL5E36ENtDxKLH0Pnmp11A+NtqvtY7mDfMFExo4/U=;
 b=RAU1V0ehZSzcZiPY6BeJNtgvg3ey134qnXmBAyL64FaH2k1gcLaKw4/+0rkiIFeHu1QXBBdZgDlGvo5iSANENmK8HXTP5lqWp06OZxVHTqWr6pvscr0nwPWOhNB1mpVr9ZJbRDqbKZw+YVC+9MJ1bZaiQrxTXw+PiqjPO2dyteTokBsNhjWMwzeZdYDlNd67CsdJ12mLGhvcE10PPKWddcYJMno+JY9ok66fQFAe7G78iFFSiaALOYQAQAnoKEWE8GszVR88aPmb4FM3kAcm89r/ssrjcjaCsOMHcA9n1ZxBbul74X/QzvTij1X0UGtXQTEVl0CCL44AMEs3oDgYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4eL5E36ENtDxKLH0Pnmp11A+NtqvtY7mDfMFExo4/U=;
 b=tLkg20oORCtyuZMItTU9dYE3SX5/lH5KmDByt6F7n7+WCv78BgElz+w7JzVfh0dE0rZK/gsKJdy/pO4Rk64RvDqzfLdJ+IbSX83q92pPMOph/AO91TrAzODSpaTOYsjLHqCwHlf8v89jF1WCyl3PPpMzlhYn9wFim8KC5dkRs7k=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by SJ2PR18MB5635.namprd18.prod.outlook.com (2603:10b6:a03:55a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 02:17:15 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:17:15 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "robh@kernel.org" <robh@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com"
	<sebastian.hesselbarth@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>,
        Sanghoon Lee <salee@marvell.com>,
        Geethasowjanya
 Akula <gakula@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add
 reset controller node
Thread-Topic: [EXTERNAL] Re: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add
 reset controller node
Thread-Index: AQHbiU1lL+VUO6yWOk2KsdzyM2pe7LNcSUkAgADBt8CAAUL0AIADt4oQ
Date: Tue, 4 Mar 2025 02:17:15 +0000
Message-ID:
 <BY3PR18MB46739700B533630D65C60808A7C82@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-4-dingwei@marvell.com>
 <d085c34a-fdbf-4950-a2e3-b3d25a1c0145@kernel.org>
 <BY3PR18MB46730C150D4CB9619B3B05FBA7CC2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <050ae833-10b5-4d80-9856-8bc2f434a74f@kernel.org>
In-Reply-To: <050ae833-10b5-4d80-9856-8bc2f434a74f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|SJ2PR18MB5635:EE_
x-ms-office365-filtering-correlation-id: 519440cd-6e9b-4a33-9866-08dd5ac2aeba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3BtOVNRbTJoYUpxY1VJTjcyZGpJWmc3YmJHNU1oVlQrTmYxYVJyY3A5U2dR?=
 =?utf-8?B?SmJHL0xjZFNDTW95WGIrcDdqM0E5aVg0anhBQ2FBRCtZUUV5cFVzaHQvQnUx?=
 =?utf-8?B?RVZHNkplV29wck5IaXd4emRnbXg5T3U3SjFMbkpxeUF6cjRwRTlGQXN6LzZm?=
 =?utf-8?B?KzNKTVlTZTRpTVpqQ0FhVk9saUhaMFFROTFCbjNMU2pxRlFuVEdrNDhWZzR1?=
 =?utf-8?B?OGltcDV1MjE4TmpBdFBOekxuL29YYlNodU5aZzFZZDh0Z1owc2MvS2VLVzBw?=
 =?utf-8?B?WXZVK2MwMVU2TkJtNGlFWVNZSHg3MUtNM1FocXNnVXJRS3k1Wm15VitkbHF4?=
 =?utf-8?B?OGdjRkxRb0xyRWFxZ2FiL0UvcDF2QlE0enJ2SFBwanNnakhLdFBtN2p2em1Q?=
 =?utf-8?B?YThsd3J1azYxNXo4K1VJYzZ3VmJRWXV3N0paS3Q1TVkvS2ZlTzZMajk4bWVL?=
 =?utf-8?B?TWVESm1MR01EdzFCdlY3MDBCVHF4RXl3eUpHSkVZbE5SMnVnTkNqU2k1MGJz?=
 =?utf-8?B?bmVjS3NMK05tRnZibW1RckdzazM3L1R2REdnNWNqRlRvbXd2cWF6SXlUQkNU?=
 =?utf-8?B?d3dNZkhsY2U1V3EzQ1ZzSEJKRWkzRUdSZno0cnpKS2FLUEZWbkRmcDM2Q0xS?=
 =?utf-8?B?OGZDWjRPQ3V2OWc0SFFLY0VSQ0Q0SkFNRjZkeG5UUmN6cFRhK0wrWFBKZmMx?=
 =?utf-8?B?WWtJL0pxYk51dkNEUVpZaWtGUGsxV29rc3Myd1ZCQVpPcm15RzJJQ1dzRkw2?=
 =?utf-8?B?Q3lIb013L2JWdFFjTDBkVm1ySHJnemM0VDVXckgyU2ZRLy9PL3RZSkgrc2cw?=
 =?utf-8?B?S0ZNT0t5OUJxRlQ0YmlhTXdFaEcxOXdvVjByeDlGa29SVGxnWER5cXAwbHZt?=
 =?utf-8?B?dEZjc2VLTkNMeVNZVHlDNkp5ZEk1N3EzbWhWMXZDT0JzeWRxWmw5S1RMMlhm?=
 =?utf-8?B?bEVCYklGcG1BTU1mVDBFbFBicWdkYjJ2c2FwNFFjb2NYWXE5aElXeUNSS2RL?=
 =?utf-8?B?N2Erc3M1dmZQWU9sVE9lam9hNHNTS3RPM3dibXpMMTd3TFNWeXp5N0hWY3JZ?=
 =?utf-8?B?SmRDSHc3UC9nYURyN2VBblJkSklLSTI5d1hIS3gweUpQRzduU090T05iWHdu?=
 =?utf-8?B?NnU1YzJXQ0VmNmIzbEZTVnR5Zy9MZmFxeEZOam1wV2VGeUwwMXkrczI2VDA2?=
 =?utf-8?B?UTJYTmx2UXNsblltZ0JHZG4yTHJ3U1g2Y3JIUW5FK0luZUNCKzh0dk1QS1hu?=
 =?utf-8?B?eUR0eW84UVIzcERWTVhNZk4vQTYxeDNzZkhJMk1FamlkNDBHVTBSR2E2eHhh?=
 =?utf-8?B?U2dCWTh4bC9kUmY2SDJBdTh0T0lCdlhrUzc3MG9heTFxYmxDbXQvdS82SDZv?=
 =?utf-8?B?Q1R3RFhDSVBJcWNkTk9RWURva1FFa1J4YzNtSXlMU1BHTnVhMFF2SHJtdFJ3?=
 =?utf-8?B?dTg0UDNuQk9QU3RUZjZMWUlXcHl3M0YrWlFyc05QNVhWU2dWOFVHWHFjYVJH?=
 =?utf-8?B?Z3NBajhSUWdmd3phZGFFWm8vUXNLWTJPSlNHc3hwZHUvZlJvY3FQTVhzeUpC?=
 =?utf-8?B?V25RSTdxOSt2eTlNdVpDTzhCNlYwSk0xaHJLdVZ0enlwbnhjYmNlUWlhZ3gz?=
 =?utf-8?B?Nmw1UjFOZ255a1hobC9pbXo1b0NBTUtIR0l2ZWE5eVlMaXNCR2RjZG9XdU54?=
 =?utf-8?B?VGw3ZWJuU3YwUU5RZFc3L1BGMk9xd01TbCtHMnpzKzVhcTRCdCtMSEJwVDdt?=
 =?utf-8?B?RDVsRWFFakpmSU5naGJ6dWw0Wit1b2owa25WeDZYZWtONVFkVmY3Uk1GYk1R?=
 =?utf-8?B?TXNRYUJDN01kTnVJQkVnNWpIaHdpblpGSVVWTCtuMDdUYTd0VjdrWnpIMXps?=
 =?utf-8?B?enIvdkVFNllnTGlNWXd1SzlKWG9WOUlTMmMrTzZVb2JDS1pPazdrV1pWSk9w?=
 =?utf-8?Q?UjJWDxwaqzEhRNS7k+42wRzGObOulVSc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzdQNWtLcnJSVkhzYndJeHQrbGRRcTFCdUxKdTM5YXB2TnFBNWJLUlJsUzVS?=
 =?utf-8?B?ODMyS0h6TXJrSUkwdUVWdUQwbUhPR1BiMVJrNmk0MVpRWC9mZEJsVkFwUHBY?=
 =?utf-8?B?K3c2bitEMDB1eUdHWnA5QlEzOXFsQXAzdEIrWEFIVkFWY2tEaWUwQ2ZxdVRT?=
 =?utf-8?B?ZjI2TGd2aXgwcXJBOG9rQWJGM1Q2RWRtc2VZL0llazJJUFZXd3VtUXZqSmJL?=
 =?utf-8?B?Zy9NM21MVlFqeW11NHRSbis5Yk1zU2RIVk9Hd0Y2ZUpnZ2lqaXBIV1dwamoy?=
 =?utf-8?B?UXJDbDdvNUMwQ3IxT296NHV2WFIvMG9NOS9WSjFvRXdaYW42TGt4enRVNjlB?=
 =?utf-8?B?aEhRWFowQXFLeER0blc5dWR5d3hKanZ6SzV2UDNlMUlISjdBV04vMUFGSnFk?=
 =?utf-8?B?OFptVWM4SDdQVzhVT1dPSm1QNU1sRXppTFBYaWdZNkNSangrUmVkNk5GUzl3?=
 =?utf-8?B?Y1ZYeSsyZnRnRUp5L2ExdUlMc0E4QkVRRGJvQnhsY3pYY0U1eUYyMFM3Vzdk?=
 =?utf-8?B?d2cweG1qOGNlUWozTC9lbENGTUtDVXhvRDRsZzE5RjlQNHpNcjN0eC9vMWZE?=
 =?utf-8?B?c1ZMUnI4Tml1REV4WGpMYW9kcUVYcjA4aVh3dTVwQ2NxVzJtYlpmNnBLdE5y?=
 =?utf-8?B?N3QvUVk4dDcvY1Z0MUM2cElSaUxzVjJqWjlpVXV4LzRzeHJLTHZIaTIzaXhi?=
 =?utf-8?B?WFFVZmNUeVIyT000WExuc1hjS1R5dk84dS83K3dMeWpLQVNsOUNWSmpHKzkr?=
 =?utf-8?B?Tm5GMDFsRE9JUzJBc1VvcmVyNlh0a2M1NWhvUHNrVDdOQ1NhQWtMaWhmRVR0?=
 =?utf-8?B?TmZmY3hudTlXOFZjU3Rabkp3N0phVmRQRnFNNWZKS2pwcTNEcnY4a01LUnkz?=
 =?utf-8?B?RC96ZW5TeFVFV3pVT1hkVVdxOVVaS0xJNHhqejV3em9yMGkwMC9IL2NpbmxO?=
 =?utf-8?B?bjZuMmhDbGZMRVY4YVJUQ2ZVVTdxZUtXMWpLZllqMUlSZFBPcmZMeDZ2b1Mv?=
 =?utf-8?B?eFdhQjhTMU4zUlpLS09MZ0JrWmQrcnZtejFtYU83U2VYM2RSU2hERTdYcUFM?=
 =?utf-8?B?QXlsZDFIa2RCTUNocGwwelhXc2s1d1NCR2dKdXZrZzJOTVRtRGd5QWVxRUU2?=
 =?utf-8?B?SHV5em9LUFpXWG5mbTdqNExtbUtvYnhvV3p0cy85Qk90UFpoVUoxUG9QSnJu?=
 =?utf-8?B?cHdOWm5QSWdOMEdrc1R2UkRkTDhaaDFZKzJ1aWQxakgwdGtRQldTMld4empw?=
 =?utf-8?B?QTJmekJCekJWSyttR1dzTlZwNkR6UDlzRmo5Y2hlZGR2WWtxeWswQTJyUkcy?=
 =?utf-8?B?T2haUGJYUTBoVkJVWXdhcGJOSklFTEY5Q3ROSHVjTlN0ZlRhaUFPNUlQSEpT?=
 =?utf-8?B?dGpHR0oxd2xuVG1vN0lTZHJJWWRVR2FXTFJpalJmSFFDYXlNdGhwc0xFSERQ?=
 =?utf-8?B?MkdPZjBWMzdvMTVZNzZUcW5wcW1Tc0RHUGdHYnUwenJpZGRRclVyY2t4TGhJ?=
 =?utf-8?B?bERBWU15dS9Nd0t5THlZMDZrNkRrdHd2Y2pTL3huZ0VYVmwzSzF5cytoY01I?=
 =?utf-8?B?M2xUNFc0QVVlWS9aR2d6cjRRcTMvcUV2bjBBeG45Qi93eFlOTGJ6TUFaQlZy?=
 =?utf-8?B?QkRLSTBaazAvdWJSZzdQZ2UyYW8rZmlwY2dnYkpZUGU0amcvYkc5cXNVWW9v?=
 =?utf-8?B?SzFLWWhCMU9XTHhZdDB3MHc3bTgxdzZnbFlMT05TMHdJQjVsZ2xVZ1dHTUti?=
 =?utf-8?B?bVA5Tm0zSmduYjhJb3RtbDdBbUJyZG1DeE5DdkJNcytyQ250RXdSeUh2ZnNv?=
 =?utf-8?B?QzBheGMwSEx1OXNSb3p2cDZ2dWlnWWxlc0o4ckVSUE5VNit5aUgzdU1ST2l1?=
 =?utf-8?B?YnArNWxRb2d0U0plWVFNNllORlJOUHhvcVNhbUthUVh2L0tRak5GSWhUYVl1?=
 =?utf-8?B?Y3hoZzk0V2g5QWVscVdIUHJmOWVWNDZhbzA3dHdHOXpGWXRKK2VySm5hbDNG?=
 =?utf-8?B?ZWF1YjNvNVVnSjh5Q0hXNjN4TkFvUFBhcUdTS05zZ2hpOUpacUdPVXE4ajFu?=
 =?utf-8?B?Sk5Salg5MUNIR0dCYm1qWjNKLzdCTCs5cjdreXZkT0krUSsxTWw5MG1CakFj?=
 =?utf-8?Q?xb9yRfOFoMl3I8NncXQXtkXZv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519440cd-6e9b-4a33-9866-08dd5ac2aeba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 02:17:15.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrrKHpbJTkMFsqqFl/RNRwIXyscTgMNrkUJrsvXtF9hXJopzOGZYfD15x/G+/4iIOZ8DUJHf6WU4qzJCjOne1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5635
X-Proofpoint-ORIG-GUID: RhJjblVczD0P3PtRDLLfpyBU5p434obh
X-Proofpoint-GUID: RhJjblVczD0P3PtRDLLfpyBU5p434obh
X-Authority-Analysis: v=2.4 cv=fqQmZE4f c=1 sm=1 tr=0 ts=67c662af cx=c_pps a=oYCWE2dcp7hbP1SgTdEJ+A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=VwQbUJbxAAAA:8 a=uP1ucDPQAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=rJIvpQBsFfvva7PvbIMA:9 a=QEXdDO2ut3YA:10 a=9a9ggB8z3XFZH39hjkD6:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_01,2025-03-03_04,2024-11-22_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMSwgMjAyNSA1
OjQ2IEFNDQo+IFRvOiBXaWxzb24gRGluZyA8ZGluZ3dlaUBtYXJ2ZWxsLmNvbT47IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGFuZHJld0BsdW5uLmNoOyBn
cmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb207DQo+IHNlYmFzdGlhbi5oZXNzZWxiYXJ0aEBnbWFp
bC5jb207IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBr
ZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBTYW5naG9vbiBMZWUNCj4gPHNhbGVl
QG1hcnZlbGwuY29tPjsgR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MyAzLzNdIGFybTY0OiBkdHM6
IG1hcnZlbGw6IGNwMTF4OiBBZGQNCj4gcmVzZXQgY29udHJvbGxlciBub2RlDQo+IA0KPiBPbiAy
OC8wMi8yMDI1IDIxOjE4LCBXaWxzb24gRGluZyB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGty
emtAa2VybmVsLm9yZz4NCj4gPj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI3LCAyMDI1IDEw
OjU3IFBNDQo+ID4+IFRvOiBXaWxzb24gRGluZyA8ZGluZ3dlaUBtYXJ2ZWxsLmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPj4gQ2M6IGFuZHJld0Bs
dW5uLmNoOyBncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb207DQo+ID4+IHNlYmFzdGlhbi5oZXNz
ZWxiYXJ0aEBnbWFpbC5jb207IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0K
PiA+PiBjb25vcitkdEBrZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBTYW5naG9v
biBMZWUNCj4gPj4gPHNhbGVlQG1hcnZlbGwuY29tPjsgR2VldGhhc293amFueWEgQWt1bGEgPGdh
a3VsYUBtYXJ2ZWxsLmNvbT4NCj4gPj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIHYz
IDMvM10gYXJtNjQ6IGR0czogbWFydmVsbDogY3AxMXg6IEFkZA0KPiByZXNldA0KPiA+PiBjb250
cm9sbGVyIG5vZGUNCj4gPj4NCj4gPj4gT24gMjcvMDIvMjAyNSAyMDrigIoyNSwgV2lsc29uIERp
bmcgd3JvdGU6ID4gQWRkIHRoZSByZXNldCBjb250cm9sbGVyIG5vZGUNCj4gYXMNCj4gPj4gYSBz
dWItbm9kZSB0byB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgPiBub2RlLiA+ID4gU2lnbmVkLW9mZi1i
eTogV2lsc29uIERpbmcNCj4gPj4gPGRpbmd3ZWlA4oCKbWFydmVsbC7igIpjb20+ID4gLS0tID4g
YXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS0NCj4gPj4gY3AxMXgu4oCKZHRzaQ0K
PiA+Pg0KPiA+PiBPbiAyNy8wMi8yMDI1IDIwOjI1LCBXaWxzb24gRGluZyB3cm90ZToNCj4gPj4+
IEFkZCB0aGUgcmVzZXQgY29udHJvbGxlciBub2RlIGFzIGEgc3ViLW5vZGUgdG8gdGhlIHN5c3Rl
bSBjb250cm9sbGVyDQo+ID4+PiBub2RlLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFdp
bHNvbiBEaW5nIDxkaW5nd2VpQG1hcnZlbGwuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgYXJjaC9h
cm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDExeC5kdHNpIHwgOCArKysrKysrKw0KPiA+
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDExeC5kdHNpDQo+ID4+
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDExeC5kdHNpDQo+ID4+PiBp
bmRleCAxNjFiZWVjMGI2YjAuLmMyNzA1OGQxNTM0ZSAxMDA2NDQNCj4gPj4+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtY3AxMXguZHRzaQ0KPiA+Pj4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDExeC5kdHNpDQo+ID4+PiBAQCAtMjI2
LDYgKzIyNiw4IEBAIENQMTFYX0xBQkVMKHJ0Yyk6IHJ0Y0AyODQwMDAgew0KPiA+Pj4gIAkJQ1Ax
MVhfTEFCRUwoc3lzY29uMCk6IHN5c3RlbS1jb250cm9sbGVyQDQ0MDAwMCB7DQo+ID4+PiAgCQkJ
Y29tcGF0aWJsZSA9ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+ID4+PiAgCQkJcmVnID0gPDB4
NDQwMDAwIDB4MjAwMD47DQo+ID4+PiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4+PiAr
CQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4+Pg0KPiA+Pj4gIAkJCUNQMTFYX0xBQkVMKGNsayk6
IGNsb2NrIHsNCj4gPj4NCj4gPj4gV2FpdCwgbm8gdW5pdCBhZGRyZXNzIGhlcmUuDQo+ID4NCj4g
PiBUaGlzIHN1Ym5vZGUgY2FtZSBmcm9tIHRoZSBleGlzdGluZyBjb2RlLiBJIGRpZG4ndCB0b3Vj
aCB0aGlzIHN1Ym5vZGUNCj4gPiBpbiBteSBwYXRjaC4gQXMgeW91IGNhbiBzZWUsIHRoZSBzeXN0
ZW0tY29udHJvbGxlciBoYXMgYSB3aWRlIGFkZHJlc3MNCj4gPiByYW5nZSwgd2hpY2ggaW5jbHVk
ZXMgY2xvY2ssIEdQSU8gcmVnaXN0ZXJzIGFzIHdlbGwgYXMgdGhlIHVuaXQtc29mdHJlc2V0DQo+
ID4gcmVnaXN0ZXIuDQo+ID4NCj4gPj4NCj4gPj4+ICAJCQkJY29tcGF0aWJsZSA9ICJtYXJ2ZWxs
LGNwMTEwLWNsb2NrIjsNCj4gPj4+IEBAIC0yNzMsNiArMjc1LDEyIEBAIENQMTFYX0xBQkVMKGdw
aW8yKTogZ3Bpb0AxNDAgew0KPiA+Pj4gIAkJCQkJIDwmQ1AxMVhfTEFCRUwoY2xrKSAxIDE3PjsN
Cj4gPj4+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPj4+ICAJCQl9Ow0KPiA+Pj4gKw0K
PiA+Pj4gKwkJCUNQMTFYX0xBQkVMKHN3cnN0KTogcmVzZXQtY29udHJvbGxlckAyNjggew0KPiA+
Pg0KPiA+Pg0KPiA+PiBTbyB3aHkgaGVyZSBpdCBhcHBlYXJlZD8gVGhpcyBpcyB3cm9uZyBhbmQg
bm90IGV2ZW4gbmVjZXNzYXJ5LiBFbnRpcmUNCj4gPj4gY2hpbGQgc2hvdWxkIGJlIGZvbGRlZCBp
bnRvIHBhcmVudCwgc28gZmluYWxseSB5b3Ugd2lsbCBmaXggdGhlDQo+ID4+IGluY29tcGxldGUg
cGFyZW50IGNvbXBhdGlibGUuDQo+ID4NCj4gPiBXZSBkbyBuZWVkIHRoZSByZXNldC1jb250cm9s
bGVyIGFzIGEgc3Vibm9kZSB1bmRlciBzeXN0ZW0tY29udHJvbGxlciBub2RlDQo+ID4gZm9yIHRo
ZSBmb2xsb3dpbmcgcmVhc29uczoNCj4gPg0KPiA+IC0gV2UgbmVlZCB0byBoYXZlICdyZWcnIHBy
b3BlcnR5IGluIHRoaXMgc3Vibm9kZSBzbyB0aGF0IHdlIGNhbiBnZXQgdGhlDQo+IG9mZnNldA0K
PiA+ICAgdG8gc3lzdGVtLWNvbnRyb2xsZXIgcmVnaXN0ZXIgYmFzZSBkZWZpbmVkIGluIHBhcmVu
dCBub2RlLiBUaGlzIGlzIHN1Z2dlc3RlZA0KPiA+ICAgYnkgUm9iIGluIFYyIGNvbW1lbnRzLg0K
PiA+ICAgQW5kIHdlIG5lZWQgdG8ga25vdyB0aGUgcmVnaXN0ZXIgc2l6ZSB0byBjYWxjdWxhdGUg
dGhlIG51bWJlciBvZiByZXNldA0KPiBsaW5lcy4NCj4gPiAgIFRoaXMgaXMgc3VnZ2VzdGVkIGJ5
IFBoaWxpcHAgaW4gVjEgY29tbWVudHMuDQo+IA0KPiBZb3UgZG8gbm90IG5lZWQgYW5kIHlvdSBy
ZWNlaXZlZCB0aGF0IGNvbW1lbnQgYXMgd2VsbC4gSXQgaXMgaW1wbGllZCBieQ0KPiBjb21wYXRp
YmxlLg0KPiANCj4gPg0KPiA+IC0gV2UgYWxzbyBuZWVkIHRvIGRlZmluZSB0aGUgJ3Jlc2V0LWNl
bGxzJyBpbiB0aGlzIHN1Ym5vZGUuIEFuZCB0aGUgY29uc3VtZXINCj4gb2YNCj4gPiAgIHRoZSBy
ZXNldCBjb250cm9sbGVyIHVzZXMgdGhlIGxhYmVsIG9mIHRoaXMgc3Vibm9kZSBmb3IgdGhlIHBo
YW5kbGUgYW5kIHJlc2V0DQo+ID4gICBzcGVjaWZpZXIgcGFpci4NCj4gDQo+IHJlc2V0LWNlbGxz
IHdpbGwgYmUgaW4gdGhlIHBhcmVudCBvbmNlIHlvdSBmb2xkIGl0Lg0KPiANCj4gPg0KPiA+IEFz
IEkgbWVudGlvbmVkIGluIG15IHJlcGx5IHRvIHRoZSBmaXJzdCBjb21tZW50LCB0aGUgcmVzZXQt
Y29udHJvbGxlciBpcyBub3QNCj4gdGhlDQo+ID4gb25seSBkZXZpY2Ugd2l0aGluIHRoZSBzeXN0
ZW0tY29udHJvbGxlciByZWdpc3RlciBzcGFjZXMuIERvIHlvdSBzdGlsbCB0aGluayBJDQo+IA0K
PiBZb3UgcHJvdmlkZWQgdmVyeSBsaXR0bGUgaGFyZHdhcmUgZGVzY3JpcHRpb24gb2YgdGhlIGRl
dmljZS4gU28gYmFzZWQgb24NCj4gaGFyZHdhcmUgZGVzY3JpcHRpb24geW91IHByb3ZpZGVkOiB5
ZXMuDQo+IA0KPiA+IHNob3VsZCBmb2xkIGl0IGludG8gdGhlIHBhcmVudCBub2RlLiBBbmQgd2hh
dCBJIHByb3Bvc2VkIGlzIGV4YWN0bHkgc2FtZSBhcw0KPiA+IHRoYXQgdGhlIGFybWFkYV90aGVy
bWFsIGRyaXZlciBkaWQgKFNlZSBiZWxvdykuIEkgd29uZGVyIHdoeSB3aGF0IHdhcw0KPiBhY2Nl
cHRlZA0KPiA+IGluIHRoZSBwYXN0IGJlY29tZSBub3QgYWNjZXB0ZWQgbm93Lg0KPiANCj4gV2Ug
ZGlkIG5vdCBkaXNjdXNzIGhlcmUgZHJpdmVycywgYnV0IGlmIHlvdSBpbnNpc3QgdGFsa2luZyBh
Ym91dA0KPiAibWFydmVsbCxhcm1hZGEtY3AxMTAtdGhlcm1hbCIgdGhlbiBwb2ludCBtZSB0byBy
ZXZpZXcgb3IgYWNrIGZyb20gRFQNCj4gcGVvcGxlLiBZb3UgY2xhaW0gaXQgd2FzIGFjY2VwdGVk
IHNvIGhvdyBkaWQgd2UgYWNjZXB0IGl0Pw0KPiANCg0KSSBkaWRuJ3QgaW50ZW5kIHRvIGV4dGVu
ZCBkaXNjdXNzaW9uIHRvIHRoZSBkcml2ZXIgaW4gdGhpcyB0aHJlYWQuIFRoZSBmb2xsb3dpbmcN
CklzIHRoZSByZXZpZXcgdGhyZWFkIG9mIHRoZSBkdC1iaW5kaW5nIGZvciB0aGUgdGhlcm1hbCBk
ZXZpY2UgKGluIDIwMTgpLg0KSW5kZWVkLCB0aGVyZSBpcyBubyBjb21tZW50cyBjaGFsbGVuZ2lu
ZyB3aHkgbm90IGZvbGQgdGhlIHRoZXJtYWwgc3ViLW5vZGUNCkludG8gdGhlIHBhcmVudCAnc3lz
Y29uJyBub2RlLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzIw
MTgwNzAzMjExMzM1LkdBODg1OEByb2ItaHAtbGFwdG9wLw0KDQpEaWdnaW5nIGZ1cnRoZXIsIEkg
Zm91bmQgc29tZSBpbnRlcmVzdGluZyBoaXN0b3J5IGFib3V0IHRoZSBwYXJlbnQgJ3N5c2Nvbicg
bm9kZQ0Kb2YgdGhlIHJlc2V0LWNvbnRyb2xsZXIuIEknZCBhcHByZWNpYXRlIGlmIHlvdSBjYW4g
dGFrZSBhIGxvb2sgaW50byB0aGUgZm9sbG93aW5nDQpwYXRjaGVzL3RocmVhZCAtDQoNClRoZSBz
eXNjb24wIG5vZGUgd2FzIGluaXRpYWxseSBhZGRlZCBhbG9uZyB3aXRoIEFybWFkYSBjbG9jayBk
cml2ZXIgc3VwcG9ydC4NCkl0IHdhcyB0aGUgdmVyeSBiZWdpbm5pbmcgb2YgdGhlIHVwc3RyZWFt
IGZvciBBcm1hZGEgU29DcyBzdXBwb3J0ICgyMDE2KS4NCkFuZCB0aGUgY2xvY2sgZHJpdmVyIGlz
IG9uZSBvZiB0aGUgZWFybGllc3QgZHJpdmVycyB0byBiZSBtYWlubGluZWQuIEF0IHRoYXQgdGlt
ZSwNCnRoZSBjbG9jayBjb250cm9sbGVyIGlzIHRoZSBvbmx5IHN1cHBvcnRlZCBkZXZpY2Ugd2l0
aGluIHN5Y29uIHJlZ2lzdGVyIHJhbmdlLg0KQXMgeW91IGNhbiBzZWUsIHRoZSBjbG9jayBkdC1i
aW5kaW5nIHdhcyBleGFjdGx5IGFsaWduZWQgd2l0aCB3aGF0IHlvdXIgc3VnZ2VzdGVkDQoobm8g
c3ViLW5vZGUsIGNvbXBhdGlibGUgYW5kIGNsb2NrLWNlbGxzIGp1c3QgaW4gc3lzY29uKS4gDQoN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xNDYwNjQ4MDEzLTMxMzIwLTUtZ2l0LXNlbmQt
ZW1haWwtdGhvbWFzLnBldGF6em9uaUBmcmVlLWVsZWN0cm9ucy5jb20vDQoNCkJlc2lkZXMgdGhl
IGNsb2NrIGNvbnRyb2xsZXIsIHRoZSBzeXN0ZW0gY29udHJvbGxlciBhbHNvIGluY2x1ZGVzIHRo
ZSBHUElPIGNvbnRyb2xsZXIsDQpwaW5jdGwgY29udHJvbGxlciwgcmVzZXQgY29udHJvbGxlciBh
bmQgb3RoZXIgbWlzY2VsbGFuZW91cyBjb25maWd1cmF0aW9ucy4gQmVmb3JlDQphZGRpbmcgdGhl
IHBpbmN0bCBkdC1iaW5kaW5nLCBpdCdzIGRlY2lkZWQgdG8gdXNlIHRoZSBzdWItbm9kZXMgdG8g
cHJlc2VudCB0aGUgbXVsdGlwbGUNCmZ1bmN0aW9uIGJsb2NrcyBvZiB2YXJpb3VzIGRldmljZXMu
DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9iMjc0OTVlMTBmYjRmNGQ4YTdmZDFhNzYw
ZDQ5NDAyYmJhZTgzYjU4LjE0OTYzMjg5MzQuZ2l0LXNlcmllcy5ncmVnb3J5LmNsZW1lbnRAZnJl
ZS1lbGVjdHJvbnMuY29tLw0KDQpJbiB0aGUgZm9sbG93aW5nIHBhdGNoLCBpdCB3YXMgY2xlYXJs
eSBhZGRyZXNzZWQgd2h5IHN1Yi1ub2RlcyB3YXMgY2hvc2VuDQpvdmVyIG9uZSBmbGF0IG5vZGUu
DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9iYjIxZWU5YWNjNTVlZmFjODg0NDUwZmY3
MTAwNDliOTliMjdmOGJmLjE0OTYzMjg5MzQuZ2l0LXNlcmllcy5ncmVnb3J5LmNsZW1lbnRAZnJl
ZS1lbGVjdHJvbnMuY29tLw0KDQoiVGhlIGluaXRpYWwgaW50ZW50IHdoZW4gdGhlIGJpbmRpbmcg
b2YgdGhlIGNwMTEwIHN5c3RlbSBjb250cm9sbGVyIHdhcyB0bw0KaGF2ZSBvbmUgZmxhdCBub2Rl
LiBUaGUgaWRlYSBiZWluZyB0aGF0IHdoYXQgaXMgY3VycmVudGx5IGEgY2xvY2stb25seQ0KZHJp
dmVyIGluIGRyaXZlcnMgd291bGQgYmVjb21lIGEgTUZEIGRyaXZlciwgZXhwb3NpbmcgdGhlIGNs
b2NrLCBHUElPIGFuZA0KcGluY3RybCBmdW5jdGlvbmFsaXR5LiBIb3dldmVyLCBhZnRlciB0YWtp
bmcgYSBzdGVwIGJhY2ssIHRoaXMgd291bGQgbGVhZA0KdG8gYSBtZXNzeSBiaW5kaW5nLiBJbmRl
ZWQsIGEgc2luZ2xlIG5vZGUgd291bGQgYmUgYSBHUElPIGNvbnRyb2xsZXIsDQpjbG9jayBjb250
cm9sbGVyLCBwaW5tdXggY29udHJvbGxlciwgYW5kIG1vcmUuDQoNClRoaXMgcGF0Y2ggYWRvcHRz
IGEgbW9yZSBjbGFzc2ljYWwgc29sdXRpb24gb2YgYSB0b3AtbGV2ZWwgc3lzY29uIG5vZGUNCndp
dGggc3ViLW5vZGVzIGZvciB0aGUgaW5kaXZpZHVhbCBkZXZpY2VzLiBUaGUgbWFpbiBiZW5lZml0
IHdpbGwgYmUgdG8NCmhhdmUgZWFjaCBmdW5jdGlvbmFsIGJsb2NrIGFzc29jaWF0ZWQgdG8gaXRz
IG93biBzdWItbm9kZSB3aGVyZSB3ZSBjYW4NCnB1dCBpdHMgb3duIHByb3BlcnRpZXMuIg0KDQpT
aW5jZSB0aGVuLCB0aGUgZHQtYmluZGluZyBvZiBBcm1hZGEncyBzeXN0ZW0gY29udHJvbGxlciBi
ZWNhbWUgYW4NCmV4Y2VwdGlvbi4gQnV0IEkgdGhpbmsgaXQncyBzZW5zaWJsZS4gSWYgd2UgZG8g
cHV0IGFsbCB0aGVzZSBjb250cm9sbGVycyBpbnRvDQpvbmUgbm9kZSwgeW91IGNhbiBpbWFnZSB0
aGUgcHJvcGVydGllcyBvZiBkaWZmZXJlbnQgZGV2aWNlcyB3aWxsIGJlDQptZXNzZWQgdXAsIGUu
Zy4sIG5vdCBqdXN0ICNyZXNldC1jZWxscywgI2Nsb2NrLWNlbGxzIGFuZCAjZ3Bpby1jZWxscyB3
aWxsDQpiZSBnYXRoZXJlZC4gVGhlcmUgd2lsbCBiZSBhIGxvbmcgY29tcGF0aWJsZSBsaXN0IG9m
IGFsbCBkZXZpY2VzLg0KDQpHb2luZyBiYWNrIHRvIG15IGN1cnJlbnQgcGF0Y2ggLSBpZiB3ZSBm
b2xkIHRoZSByZXNldCBjb250cm9sbGVyIGludG8gdGhlDQpwYXJlbnQgbm9kZSwgdGhlIHN5c2Nv
biBub2RlIHdpbGwgYmVjb21lIGEgaHlicmlkLCB3aGljaCBHUElPIGFuZCANCmNsb2NrIGNvbnRy
b2xsZXIgYXJlIHN0aWxsIHN1Yi1ub2RlcyB3aGlsZSByZXNldCBjb250cm9sbGVyIGlzIGZvbGRl
ZCBpbnRvDQp0aGUgc3lzY29uIG5vZGUuIElzbid0IGl0IHZlcnkgY29uZnVzaW5nPw0KDQo+IEl0
IHdhcyAyMDEzIHNvIHRoYXQncyBhbm90aGVyIGFuc3dlcjogbWFueSB0aGluZ3MgZG9uZSAxMiB5
ZWFycyBhZ28gd2VyZQ0KPiBkb25lIG5vdCBhY2NvcmRpbmcgdG8gYmVzdCBwcmFjdGljZXMuIEFs
c28gYmVzdCBwcmFjdGljZXMgZXZvbHZlZC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQo=

