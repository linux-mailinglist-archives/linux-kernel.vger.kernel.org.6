Return-Path: <linux-kernel+bounces-406798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F15489C65AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E051DB63CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0B121A707;
	Tue, 12 Nov 2024 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aXS7/I8S";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="evKt5K8V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mTOErb6N"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6753821A4CE;
	Tue, 12 Nov 2024 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449698; cv=fail; b=sCo6U2sCmrpzzyEb1LhYYm1YsraRcJGg7Ef27WqCfS2gj6XHdqXLSSf4MgkdCALjBPkbwLK9mdAok7WHcSn2h8mjnMXNmcsPuEilJ5HJrRmpC9fQeUuLGkVuU52TSPSfJZo3xYPgRYMtVWYQASH23UFIYUqaF4q6yiJa/7T5I10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449698; c=relaxed/simple;
	bh=JYUjwC34ClQGbvXf2MNHor9QQmNiMHV620qIwpP7vng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XdkFZJljXixE40NH0B5Q0pALV39BQK/AwvfoZyugUwBlPG6973RO0SeW1rUQ7MVzp41GqZKa/NBo2STOIF1EQx95Cs8uSYHZ3FYRFqT8HU2u3X0dK3aP4oFUV4cqnS1u5Jfu/dmOgr7YU66x5OjYn6xC22rDZ92s4KhAvYeSApw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aXS7/I8S; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=evKt5K8V; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mTOErb6N reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACJsF1x022172;
	Tue, 12 Nov 2024 14:14:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=JYUjwC34ClQGbvXf2MNHor9QQmNiMHV620qIwpP7vng=; b=
	aXS7/I8SaNLkEZtA16yJVGgKaUhk71IS1iAHL34o18FmvYH9kwCXhBCXNAL7N5Sa
	omWZ4/uv4Qe++L+3ze5YB1ns1Ipl8RS4kOvMJhQk3FbJfOCnGwn7LOBIWEb+mwWY
	prnXh8VZ/9Y5Zo0uSiryKQM0eDNsw/jRiJcXmsa4YciQ87FeUBdsBz1la5AJBG7H
	sayPmoaxlQlAGOaVaYheUCjz0C7gsc+hFKzdwA0kI6AFTQj1sl6ISgOmj1rC5ZwQ
	lMPKs80J5URUOSWllvcgG0NYgEw8HMRxsx6pnWmwgrBRUorjooIleJdTH3l9PJxR
	9APkHIqlpjm/NzEl1N/5Rw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42t7mu2k1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 14:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731449692; bh=JYUjwC34ClQGbvXf2MNHor9QQmNiMHV620qIwpP7vng=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=evKt5K8ViJCNuPP69X4jo3ak6jk58z22GmXe5UdpocT1Sl2VGmUM6qmIQCqgq7MaW
	 8AUB8bPumeSvc8MXg9gPvV6t+UgbvPvxvwNPO+PUTT6Rn6fRpiRtStejyCwmHK119A
	 7OmN9Dxd9JQB3vCOz9ne7jEGD+Fvovj76IHyHclkxvgWvKLfktAolF7+26YGbDdcDO
	 JSdWjRc2EyWT6H1GdSQgsny7NK3KarN/tEZldAN+vno09j3pSULfCWBOmbzDzgOBKF
	 Z2vbLvqAX753QUYyyDdcxmSmw5xa/4fc9ScXLcuDE9oPQB4r0eaR1qktRLi4Qs3Bdw
	 SURotVoSZU00w==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0D9B34024D;
	Tue, 12 Nov 2024 22:14:52 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id ABC2DA0071;
	Tue, 12 Nov 2024 22:14:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mTOErb6N;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 56C6C4035B;
	Tue, 12 Nov 2024 22:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUxOF+DL+oEP/cfpaZmfSEGZmF1kjVyFR0ovH9ifWd/N63s1Ao/tQLTmDyOGqE9bI4DLDaczmv+weA3u4mrK/YNePlYOFoMLjWes42cVq3HkFEoKChLBQv/ckPim42lWdLDD1lP/yG+9GYDUFiIP8fHTqmzqd711L03ENXpjInoF+B3xRJGtCGF37q1ovLstSgO+YHWwfMxwlQGNRX0X0+FkJnBjp7czP5PHjMSOf549s9g6+zYZcdBfdSumwItZlh3W3EhXeZlX8Q5fHjBcz1PnK1t7BjzeA+iX7OkUQ0FkdNw9jEcNFabKTmxia7XbwareASM8cZL9ExdkAg1x/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYUjwC34ClQGbvXf2MNHor9QQmNiMHV620qIwpP7vng=;
 b=ogRKnpY+l1S4XqFJMQ7EoBBGDXdhOkDyGLWRl8Md+TKNKxuRiyw8s3iCzMiPJHd71jTiR0Qxd8YGjRXwDGmPUkFFJ7yXaKFcx4CTZNRhtyxdc6DkaobM1m/vHMeodDoOWL2wXjjkSK6Es94m6gEDAy69DdUaETcp/Lt2qRM55gdF3JtYVUqezZ0c8fVs2psMn1k0KSQrP3x1xpaWjiNE9TIkNaawRtfUOKz5G0fJZ2FU5M+KuNf0vhhP6C8PwsfhGuKKmMa1zMI4+uPp5oPYDJzAYxYSFCNXCKkx43rBZLWcQBGOFugrGCZ9ebOccEZCcidZmT8hoezba83DN7R0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYUjwC34ClQGbvXf2MNHor9QQmNiMHV620qIwpP7vng=;
 b=mTOErb6NTTiJYVKTSwD9tOqEOAjJvAHIb9eHtG89Mbx8PokDGfZEAGX1MnoaecbNa29ZqYIbP0zIRKDi4Gjud2PlCdxVrjRjpyZ78uJhyZXTYMY4X8rWpZ3fS2vEUPv3PDSH6JguR7CMLBBVFHzOug205nBJaKIBXwK04hYPsgE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 12 Nov
 2024 22:14:47 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 22:14:46 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: core: Set force_gen1 bit for all applicable
 SuperSpeed ports
Thread-Topic: [PATCH] usb: dwc3: core: Set force_gen1 bit for all applicable
 SuperSpeed ports
Thread-Index: AQHbNS+WUGvYt2jea0aPt6SOjsYY2LK0Ni4A
Date: Tue, 12 Nov 2024 22:14:46 +0000
Message-ID: <20241112221444.2hm3eb5swxjacthh@synopsys.com>
References: <20241112182018.199392-1-quic_kriskura@quicinc.com>
In-Reply-To: <20241112182018.199392-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB8005:EE_
x-ms-office365-filtering-correlation-id: 1832a6c3-61c4-46ad-7b24-08dd03676b0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmtQSmVTTkVpLzJlblpmeVR3d0RjS1hUQldKMFhUVmhObVcvMnd4RXFRazgx?=
 =?utf-8?B?R082UEg0VHlRL1lhRkR0RHp6QWNDMloyWURtb3ZQWXFoWkVjRjNYWExOUjht?=
 =?utf-8?B?RFhROFFVcGxZZUZ3S1ZDRnUvM1RBK09tQ284S3ZaWit4VnMyVmwrRk02YmR5?=
 =?utf-8?B?SUdOQVJsUW9UeUVEV0k0VndFMlUxWHhQMVFKTnA4UXJDS3dUaFZXcUlGelI5?=
 =?utf-8?B?akxUVFY1Zk9vSE5mTWxmVHZUeTViMnBPSjI4eGNkTFhtZTFXWW9Zd0xBZG1Y?=
 =?utf-8?B?NENmbWVVODlRVzZmbHJ2Y0RuYW1seTZacmhDRkZmUVRnSVNJbmg2N1c5MFlD?=
 =?utf-8?B?UjBHRzlTQnZlL2RKODFHbnc4MVBJdmI2aCtSYVY3Q1dVdE9hbUpselM5Y25w?=
 =?utf-8?B?TG12dUd3LzdYZVg0UFZDdkpkcExZMDFlYVVMVlcrZlhSSmtJdjBMVjE3d0p2?=
 =?utf-8?B?c0tjNVA1ODM1cDN1ZEE1cDlOeU83ZWJkeWNKbGdZNDJGRnl2UUc5RWw3TllY?=
 =?utf-8?B?ZDNqSUtsb2F5dTZJL202QmdkY3hrbWpmK0JZT1F4bjZWRWhRcnNCdlI3Y1oz?=
 =?utf-8?B?eVErYkgzQTZ2cmNmUWQ1SlZzam9vdmtRbThha2Y4UC9RZ1huNW9LdStuRGJT?=
 =?utf-8?B?cmk3N29UclMyYW1IQTJISVpjQWIrdVFsZDRzYm5WK1AvSkVIdVhBN2czbmpw?=
 =?utf-8?B?K1pMaUNyeWxjRytzYU5zeFJrQzEzZHpDWXprVytSY1lodWJMTTlha3QyS0ZG?=
 =?utf-8?B?YXdCSC9KYmhMQ1kxR2k0dWVmVWliMjlVRFBrSHhBck1RenF2RWQxOVpyNy9M?=
 =?utf-8?B?aHRsbXdPSTN5c3BZVVdBdi9KWVlESWdwVFZZRFBka1NKNXRkNjgzb1FjMXlx?=
 =?utf-8?B?S3grS1J2alkwVEJJalR0bE1lbzJ1ajRYcSswRitSTHFES0FpRXpEU3RYMUlK?=
 =?utf-8?B?Q3dXM3IyNmswU1loODJ5WXdUWGdKeHVtSWhvcTJsZXdRQ1E5dWJUUlBtWHEw?=
 =?utf-8?B?dGxNZWlXYkJzdFJoQVcxcmtqVXdMN1lteUNCRFhFV2UvcVpOL2Nub1hVeHlr?=
 =?utf-8?B?b05xbzZudXY4aTJHQU5QNDkyVndTRnRTTDNJRGVkd0l1ZU1Uc2JWZnZGaVlw?=
 =?utf-8?B?NWRjUGR2QlB1Y2Y4NjNvWE13UXE0NWxFMlI3VVNydE5JR25FcWlsbFpXU1JF?=
 =?utf-8?B?TDdmNlFlYXhkU21lT01UREt2Q2pQUVBlNmRXdGcyMzEyU1lmelRuc3FZR0Jr?=
 =?utf-8?B?WE1wUlZ2VDI4S21pcm9oNnh1UjZkRGxIdnBqdytwbUhDQURjdnkxTnVORHhr?=
 =?utf-8?B?U2htVFIraW12Ky9CbU9QdHdmOENuQWhQdVNoS2FxN2VKaEhINmg3cXdBcVdz?=
 =?utf-8?B?T2dSelFHbm5OazVQUXlRT1E4ekJLOEVkYUwzSG1zQUhRTDVLWVVRTENhei9Z?=
 =?utf-8?B?N0hrME1GV1ZBN2RmNS8zTzhicXk1Nm8yOFZHcTU1TVo0SVhHTUd6NThZemxm?=
 =?utf-8?B?Qy9zMldRd0ZaVmVONkE4WVE1V3lzNWRJaTlDUlgwS0duRzZtd01WaGQ1T2Z1?=
 =?utf-8?B?RmZaZmh0RU5qbHk1WDBMQ2NuUTRTN0dEQnhVY0VqRW1SeXdHU1Ywb25WbTd1?=
 =?utf-8?B?MFl1WG9tZjJtMXhtZ3BOUWc4SGZtODVQYm10ODRoNFpaSjRuS00rUmpHeEFu?=
 =?utf-8?B?SmJNN0lLaERtS3Q2cFNMS1ppVWJ3YW5GaFBWbXJsNjJBckZUckFnSEh0MGc3?=
 =?utf-8?B?L1ZYNURYQ0QyL3JCM0FZUmxCdUF0NWdHUlJPS1g5UzVUczdHS1FiN2hxZjNx?=
 =?utf-8?B?YjEvVkloSGVxT3k1cE80bVRVcElFbVlhM3RsVkQyVHFNVUhYbm44UW5QNkZo?=
 =?utf-8?Q?VQu78pL1Mf28Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0hObnVNUTRlZENxT3pmTEYzNElLbG0vU3VRMkplYWE3K0FiNW1qblpEZWEx?=
 =?utf-8?B?djRUZWFjcnBOVy9FTVdTQU1tK0Z6cGlhb2FrMlFZTit2clY2clFjd3oxQUwr?=
 =?utf-8?B?UTkwNndpbzhjNnRYcGJ3WW51NVVrS1d1YjlsZklpUHUrL09jbzBOMHVzQjRG?=
 =?utf-8?B?bWtFTUhyOW5GbXIyeXdTVEhOL1llZDlDSWRGTFdrM2ZmTnRLR1FDOXN6MytZ?=
 =?utf-8?B?OWdZdFpVVzVRaFUzZ2pPR21id0FQZzVIbi90QlhRRmI1MStlanZKRjd4TThk?=
 =?utf-8?B?TmtLRFBuTXFaajYzNG9SYzhTMjRQMEJBUWV2S0hPS0pCcVZwSlB5MUlPcXRk?=
 =?utf-8?B?OUQ2Vi91a2JoTGR3c1crYktHWmxKNGJXY0dNdDNkai9XeDdOaGx0VGhmVjJx?=
 =?utf-8?B?elF1a3hVZXdDTW5HWjVRcmdIK2hVUHZhOGpPOW5vVGovV0MwZ1ord1FQbmRv?=
 =?utf-8?B?UXlKVE1GSzRIVW9YRDFlTS92Mlpic0pNMFFvQjN6YStVdjRzMlE0Q1Q4TEVQ?=
 =?utf-8?B?OWlaWmtucjFYblVuOWxyN3h6UWdTQ1Y5a09uWCtQb25mQndpOU12SFE5bEt5?=
 =?utf-8?B?M0xvT3RnYXlvL28rWU12eEdvQkFjNFBRSlVNMDc3cGc4TGhITkVVOWtzUDFn?=
 =?utf-8?B?M1FWcE96eVpoTW5yZ1FWS1drR2RrS3o3TU5oQVdnb3o5TWcrMVhQUUVvYlEr?=
 =?utf-8?B?VHRseFEwV0pOS1hlTnFvVHZCUG5yaENzN3E3ZzE3YjdBS25QSmYyS3RGMXJF?=
 =?utf-8?B?WnZnTnFTN2NtazV5Y0t6RUpndk16clgzeU9pN2k2VCs2Ykl6N0M3RjJDVTYw?=
 =?utf-8?B?MDkxNzU1MnBLY2Z4VVlXSzB3SmJuQjRRU1luUGdLZDJlc2VZNnJRanZ1QXlr?=
 =?utf-8?B?NGcrZE16cHgwc1lqSzJzZGczQ3dpYmFLSTNOc0krd05SK2dJYVhoU2NJYVVX?=
 =?utf-8?B?aXJQbTdGRGY2cGlTWlVQN0ttbzV5RzRGRjRteTFjTUxqam11dkdqekxTNWgw?=
 =?utf-8?B?Mmg3TUNRdS80Rk1PanNKMUhINVJObFpjc3NtUnBwNS9HeWlWbXpaQUFDaVlo?=
 =?utf-8?B?dHI4Ri94ZmpKMGFxMVEvTWFTRy91elRENU1hS05NSXptUWdkM0oxU1NOWS92?=
 =?utf-8?B?dzNXL3VpV1F4d08rYUxPSUxORHlxblVrS0VHSHpPdlpWaFhkSFo4TGNEMW5V?=
 =?utf-8?B?Z0hPVCtrblR1QzlnRyt0TUt3Rmp0bVBqZDErUndVUzAzclgvemRxOXlVZ2JQ?=
 =?utf-8?B?dlVoeFJoSnJHTVFLT2gvaUErR3JRb2JhMUY0TDZUQlBtN2RtL3EvTVZKeERJ?=
 =?utf-8?B?K253RkExMWxXNms2M1p4ZDZjcGJYV2pSbGQ2cHpTYU9paGlSSnlJY0x5RjlG?=
 =?utf-8?B?V09lRmcySUMySHIzNkFXOTBuQlUzME9QekFCeng2MnRKMGE5UFU5RGE2anln?=
 =?utf-8?B?VjhBNWNCRjhDOVQ1QkVsQ3JLd0FRUVhoL3hmZDBpazY5RTdBQ0FlUjhLd0wy?=
 =?utf-8?B?anlVQURSYkxnck04S2MxcjlHM05EcHREejZ1NERpdjFiNGk3L1ZnODdRNmQr?=
 =?utf-8?B?Vkx3azlsRVBBTmEzRmh5MkZtZ2Y0ZmVaQThqbTNqVDQ4TU9qdWdudFFldEJn?=
 =?utf-8?B?TlA0VHd6ckovUlpIcTFhUlJXbk1FRjBDc0RHMDM4cEloT2xXRHI4Rk5lS2hK?=
 =?utf-8?B?UUZHVHVGcGVIaTdsTkR2dEgwdUpDQjlFSUtEaVdhN203QTFvQ0RYZWZaYW9p?=
 =?utf-8?B?WWsvUnFDRUxXUmo3cERtUDdCV1BIcnlrYUx4cWdacHg1bE5UN0syVm9RNnpE?=
 =?utf-8?B?aTIwUExnWHFSSFU0dmZZYVVuRUo2ZVMxcGFNeGV2VlBqc1UraHRwQnBTREhE?=
 =?utf-8?B?S1V0cVZ6Z2xzM2V2aGUrd2ZCN0piNUtMU0JMTXQxWEw2SHp6L2dwek5SbFUw?=
 =?utf-8?B?ODVYQWhkNFlMcHpNN0wwWlQrOTYvaFBRQit5MUVSQzlsZTV6Qk96QXZFTXAr?=
 =?utf-8?B?L1JtaFk1OXJqeGdDS2VTZUJKWUFXUHFwMm5iMFdySnp0WnVXY0NQMlVqQWZM?=
 =?utf-8?B?WG1hY2p3NjhJZlcxVkNyczAzL2N6RnhnS09Id3FlTjVvQ0hoUTdURjlIZUVX?=
 =?utf-8?Q?viQmPxcIVP9T5krxEo9a7IrR3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B60F48414133E43B7CB6D570219CB6B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i+6RnnKGAkAxSYoonPcHwfwL3xmApsK/a0NtRyHPmCiNntGKGEe6arcc6GhmD060tylwQRa4AL8NM+LIOVPblxSFWfHdjYOg5AxFZgln2wwqH13639ZoPc8+oy56Met5QmMkwiB37Az7k2OOQDANcRh+ICO62nI5jMWNP++BwptvIKs/mWfxR7hGRvuzW62xsAPQll4Qs+pGA7rqCtwY/N/uX5D6U7VJ/MuXyla45xacikeEbfv00tHpU9j3ftkpaLCb8zeF1GGpJwBWHt7iwWRG+jTI0xbxZWG9M0D8oedokYQPZX43Ypez0WchS10QlkohzJMu6CZOezsCiTW4CSVVEqcyHKVptHqBFhtJotyFaXFUSzKxTLACGbAYcEyBlZ8Ck0g5G4lR2hbfNBSYQs06iXg0iMmjfoFzcaE/4/J468bjoOOxUQss1BKTW7uVIJFYRpg6tXE4OoLHAWjNAjnBYBAutRDon+vE8OzjcmTxd+FsrBGMmMLi1+fwdZl25g5N8L29Iec0iNF7DVVw5aQJzV+VAM76g8eKUW2FqnBwVBlyTclKL9gmC3e/FJSpB5xu0ZMgzkNXsJm4MM3N8LE3eDE55V1OHi8XTH3D4aEqwBDcU/ckuKmEb4qpggSTopHrREQ7RxZYPxXuucigsg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1832a6c3-61c4-46ad-7b24-08dd03676b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 22:14:46.8438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +v3ggJsazykTDGKd/767DpO3W7lL/9RB079VCz1RVo0K+oZPnA7bxHGkGlIelde0qaeDH38Zp3xsL4gMrVY+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
X-Proofpoint-GUID: 8eHPi-M4JUko_TzJPvAVmT85ZdPg4k-E
X-Proofpoint-ORIG-GUID: 8eHPi-M4JUko_TzJPvAVmT85ZdPg4k-E
X-Authority-Analysis: v=2.4 cv=Y5mqsQeN c=1 sm=1 tr=0 ts=6733d35c cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=jIQo8A4GAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=fkNxI64M9cQlG1Mued0A:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=836 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1011 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120177

T24gVHVlLCBOb3YgMTIsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBpZiB0aGUgbWF4aW11bS1zcGVlZCBpcyBzZXQgdG8gU3VwZXIgU3BlZWQgZm9yIGEgMy4xIEdl
bjINCj4gY2FwYWJsZSBjb250cm9sbGVyLCB0aGUgRk9SQ0VfR0VOMSBiaXQgb2YgTExVQ1RMIHJl
Z2lzdGVyIGlzIHNldCBvbmx5DQo+IGZvciBvbmUgU3VwZXJTcGVlZCBwb3J0IChvciB0aGUgZmly
c3QgcG9ydCkgcHJlc2VudC4gTW9kaWZ5IHRoZSBsb2dpYw0KPiB0byBzZXQgdGhlIEZPUkNFX0dF
TjEgYml0IGZvciBhbGwgcG9ydHMgaWYgc3BlZWQgaXMgYmVpbmcgbGltaXRlZCB0bw0KPiBHZW4t
MS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3Bz
eXMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJh
QHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gU3VnZ2VzdGlvbiBwcm92aWRlZCBmb3IgdGhlIHNhbWUg
YXQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyMzA1MTcwMDMwMzcuaTdoc2c2azVmbjRleXZnZkBzeW5vcHN5cy5jb20vX187ISFB
NEYyUjlHX3BnIWZ4Q1ljR2R3RGFzd08yUU1HbUpZUEkyakpxdXN5aUx5OEx6ZU5tRTliZ1BvRE1y
d3RFQWpBSWNHb0trUU5Vc3VFRjJrdFB4Q2NvTWF3bzNzU3hDSkJtbHNsZ1Z2OWckIA0KPiANCj4g
VGhpcyBwYXRjaCBoYXMgb25seSBiZWVuIGNvbXBpbGUgdGVzdGVkIGR1ZSB0byB1bmF2YWlsYWJp
bGl0eSBvZg0KPiBoYXJkd2FyZSBhdCB0aGUgbW9tZW50Lg0KPiANCj4gIGRyaXZlcnMvdXNiL2R3
YzMvY29yZS5jIHwgMTAgKysrKysrKy0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAg
MiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiBpbmRleCA5Yjg4OGQzM2U2NGQuLjY3YWVmZGJlMWQ1ZiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gQEAgLTE0NzAsOSArMTQ3MCwxMyBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9p
bml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJaWYgKGh3X21vZGUgIT0gRFdDM19HSFdQQVJBTVMw
X01PREVfR0FER0VUICYmDQo+ICAJICAgIChEV0MzX0lQX0lTKERXQzMxKSkgJiYNCj4gIAkgICAg
ZHdjLT5tYXhpbXVtX3NwZWVkID09IFVTQl9TUEVFRF9TVVBFUikgew0KPiAtCQlyZWcgPSBkd2Mz
X3JlYWRsKGR3Yy0+cmVncywgRFdDM19MTFVDVEwpOw0KPiAtCQlyZWcgfD0gRFdDM19MTFVDVExf
Rk9SQ0VfR0VOMTsNCj4gLQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0xMVUNUTCwgcmVn
KTsNCj4gKwkJaW50IGk7DQo+ICsNCj4gKwkJZm9yIChpID0gMDsgaSA8IGR3Yy0+bnVtX3VzYjNf
cG9ydHM7IGkrKykgew0KPiArCQkJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfTExV
Q1RMKGkpKTsNCj4gKwkJCXJlZyB8PSBEV0MzX0xMVUNUTF9GT1JDRV9HRU4xOw0KPiArCQkJZHdj
M193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0xMVUNUTChpKSwgcmVnKTsNCj4gKwkJfQ0KPiAgCX0N
Cj4gIA0KPiAgCXJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBlYWE1NWMwY2Y2MmYuLjI5NmNi
ZTg1YTQ5NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTE3OSw3ICsxNzksNyBAQA0KPiAgI2RlZmlu
ZSBEV0MzX09FVlRFTgkJMHhjYzBDDQo+ICAjZGVmaW5lIERXQzNfT1NUUwkJMHhjYzEwDQo+ICAN
Cj4gLSNkZWZpbmUgRFdDM19MTFVDVEwJCTB4ZDAyNA0KPiArI2RlZmluZSBEV0MzX0xMVUNUTChu
KQkJKDB4ZDAyNCArICgobikgKiAweDgwKSkNCj4gIA0KPiAgLyogQml0IGZpZWxkcyAqLw0KPiAg
DQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5n
dXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

