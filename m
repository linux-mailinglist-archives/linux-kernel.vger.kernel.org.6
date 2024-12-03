Return-Path: <linux-kernel+bounces-428553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4239E1088
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56554164E99
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF122611;
	Tue,  3 Dec 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CHaDTbEX";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Luig2xts";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tHqNJQ1Q"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE042500A5;
	Tue,  3 Dec 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187031; cv=fail; b=C+qh1aMUNml6kcYhhBD+BpLv/ftgRVySxbdYaJ25/ToFc+pLWD9ZmEbx6BinvBRlijX+lYyGTwuac0SxHyMYrJZ6b38auLw1EWy2DI7LsZ0CqvTfX1ikgh9ccJqInRcv/vGxh+b7Cb3TlskjRINErK1EVBSlo4QQWXtLu/IPKK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187031; c=relaxed/simple;
	bh=BawRT2g9jciZqH9DBeGGGL16VWIDpHbHq8w7Z6h7xOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AzPGBcQ4jOIjbUy0FzysQitzbzO3ks0AymPME8LBUrKC7lU6heLJWKc34JMM/sk6yKaWPWI3DZ7SU7FOivFhQ31YDd8f3SOdawQbXgvFeG3a9NEnouIrIvPCS490CSRHC6eKFcvhDmk6YX+/Z8d9WM9E5ThhilmU7VJdiM4t0Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=CHaDTbEX; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Luig2xts; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tHqNJQ1Q reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2JHAMt012641;
	Mon, 2 Dec 2024 16:50:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=BawRT2g9jciZqH9DBeGGGL16VWIDpHbHq8w7Z6h7xOM=; b=
	CHaDTbEXjSUWbkTknO/XV6417+sVXpy+JEYQplGPWeTr44F4jRQqaRrwIiLCC3xl
	WFnsAu82Wjn46Hzco39PYizAiD++/wNYrTqj34RSBeFRHq3/CfTsrdlV8AK5ZE+u
	rB9BP/wyH3rzn52SKf5yZ17ORkiCMxt8KE1DyomcGqGuFlwdBLJ7Zi/72l1HqM0Q
	n0d6O5WZghrjAjpFEoBTMc/l6TkFL2MhT7AiuDrBn9j9RJY9yc+xdtbDK2VmAsky
	j1f4PEVg9Ng6YXO5+pf/S8eP8S/bQ0Avk3anDQpGaJOWHEiSOpLcZyuKLQf6EdiK
	KarBecYxwDQ7hnUFkv7iLw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4382ktaj5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 16:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733187009; bh=BawRT2g9jciZqH9DBeGGGL16VWIDpHbHq8w7Z6h7xOM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Luig2xtsE9p5n0TONIy80afXrh2MvWDMdxXwyQm6pTVxuDLbNDO2qCeynOw/bRXBs
	 STIN4ZBCal/5XJInsvdpNj6eRbwDZbrbhkaspYLmOH5NfAX/JvoewUOFZZ6hzhHilS
	 Tcn3LnB/AHcKiqCti/tO0KOVjRO2turstd6hN4K6ZOYTVeVEGsLJ3Vcp5N4Byx+1p5
	 0BZn2BcTeFuc1eY2NbyUVi707MUKBerQjkAbMyULRTSXUDVM8YcBUV9wQ9JfCEyo0J
	 zv3r8H0CvJ8/VnV2qYt8seyIYAI4FoRRJAirvSsg2Sm2UooHbt0e70jQNHmyUks8D6
	 w9KtEwXqCdjgQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7466440592;
	Tue,  3 Dec 2024 00:50:09 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8D2D6A0076;
	Tue,  3 Dec 2024 00:50:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tHqNJQ1Q;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C1C5E40AE8;
	Tue,  3 Dec 2024 00:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrHN5sPZk5C9c7q8j8AUjDwlovJEuKT0nqMJ2yjEUHxQT7UcdDeRJocHDbnVe75WPP/6GQB3EyoVizlnUXkfjrJF/AqG08LdHIlDW7Xuy3/YjzgOQU6tlXJsindLYVansEtn+d40Vcq3kglpp6qokRMa5F9HLUP1r5vtwfGI2NEyc4jP6Ry86wRqV4d5UbFkXY9F2P3pji4YrCqoc4a4XdgCB6dD1QGgYQGAc6hEn7zGr88mruRDjRBFCzEJUp8/eio/oTdVylzVneBph4u654zek7FGCNnzRMoi+UxqrzLbLI3HYcAwxgBNvT/ICJDh2b6slClEJAqZAtq6VbPQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BawRT2g9jciZqH9DBeGGGL16VWIDpHbHq8w7Z6h7xOM=;
 b=lWoo6SVbEzm2epnXTH5+/FSz1Z0pR0Y4vMeryBpgYX4pLLWqaTROU5nCQJhqvdgVW8J/CD206a7fzPBrTrgbH6x7re+HgLY7kXER6xpF5DiSIZS1f8TAqWmJQmg8TSTlC6XHpEChhbWbY1OpslR6JTXUoTDL7lLIDlySGpLW2JYBm5hk9DPF/PfN2FtDlJe6y7fAo7rz7SWvqYWsBaIcCW1xbwuwfSmr9+Zr8U4ebVZE5IZuHRvaJ+km2q2mVuHXEwc7R/rSMekm9FfNdTJ2eFN66TRV+UgEffZmcLtrVkHJnOC22yFVVDPun4nfqvKG7MvtV0/b/d1l6pTthDAkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BawRT2g9jciZqH9DBeGGGL16VWIDpHbHq8w7Z6h7xOM=;
 b=tHqNJQ1QkT+2v3j9UfnKCK5RTs18O5NGIgxLu/LPRGfDhXMuRKUrRYv+Rtrkd8sGWKC98KzeXS2HyxmmwsdGgjKgTx/M/Vzm10GSfemu/2J33zXOUNlJPbduqPFZX81EPj6ZgNTad7JuW109/H/3Xfy+EcE5J5ZTEXGsSGLtuto=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 00:50:02 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 00:50:02 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, "srk@ti.com" <srk@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Thread-Topic: [PATCH] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Thread-Index: AQHbPOaCI7R13zfU+USZwOYHfSs+F7LIVIOAgAAKgQCAAcieAIABEbuAgAiHX4A=
Date: Tue, 3 Dec 2024 00:50:02 +0000
Message-ID: <20241203004955.bc5haxkakzwmhjgc@synopsys.com>
References: <20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org>
 <20241125182343.bfnecsub2oxohrns@synopsys.com>
 <523727cd-7950-45b1-a0d3-3f978e789015@kernel.org>
 <20241126221536.n4ecwbndpelx3bmv@synopsys.com>
 <1abbedd9-f34d-40be-9d3f-f33fcd012cb3@kernel.org>
In-Reply-To: <1abbedd9-f34d-40be-9d3f-f33fcd012cb3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB7419:EE_
x-ms-office365-filtering-correlation-id: 1cbd4a2f-7e7b-4814-612c-08dd13346bd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEpyMVFZdjRUUmU2S3JGK0g2R2w0RjNxUmFjZmN3SjJTcXgyUzE2djgxTGpB?=
 =?utf-8?B?RTRlRGNuWHdzQkszbSs0SGpGVVpXKzBsVjV1T25CMXBGajRFemZaVzlNWUs4?=
 =?utf-8?B?QjE1ZEM1Y1puUUgrTEJYMW1QNENZalhqb3REN0pMcUxOTnBLeFg5cWt6cklk?=
 =?utf-8?B?bEdGUkxzOGRrQm0raVZtUzB4QUwxazUySnYvNEtUaE1VdjF1YmtlbzFVd3U1?=
 =?utf-8?B?R29aekZMMWUwLzlHaFBBUlFDcGRSak9sNlV2TGhJeTJJRDN1Y2JTbFVtMkhv?=
 =?utf-8?B?UFd3YzBLY0JpVzBqWDQxVEtZWC9STEw0L0l1cUU1b3ByTzc5RldkaGcrRVV1?=
 =?utf-8?B?eVZYNnFFdVhmdmQwT1dhUEpicG56cEVtZGVRWlZodVJ2cHIwS1BYWk5yYTJn?=
 =?utf-8?B?b0ZzTE1sekhBNU5GRkRFYkpWUDkxNzZ3RkNaTE1lRnpMOFkzVW5waU85VTdw?=
 =?utf-8?B?Szh0bmZBUTlyVGkxVzNTUnM5NkJ2SmZwR293YVB0YWpQNzAydFl3UCtuQWZI?=
 =?utf-8?B?OVNVQjVWc0JOdnB1dGZCaTltSVlWdmxaZjJZSHpOUk5KN0wzOGRCWnZoZkQ1?=
 =?utf-8?B?NDFkOWplbmxNWHd5eFprSExqS1VIVUp0c3JTU3d2cXVtc0tLR2Z5U3J6QTNH?=
 =?utf-8?B?aHZWNmh1S2hwdTJnT25iaFFxQ1JYMnF2WjBLTDNsVkhMeXFBQ210Z3l5SjdB?=
 =?utf-8?B?Tkg5SGdjWXJsOUE5UEREUCtIaXRMdzkyY0NqV0lldWM2QXJVc3RnbWpDaDVq?=
 =?utf-8?B?QlE4eTNUT1FoeTJHbmFUZDh0a0FPSmcxYUJkYTNtcFZ3cG5JbUgzU1RkZXFL?=
 =?utf-8?B?NVB3Nytlb2F6b0dwMmZZVno1d2FrdVJXR0JRSzExT3YyUnZQdElQN05sVVU4?=
 =?utf-8?B?ZldVZEdTY0RTN1VDaFBlNGpCOU1RbTlTUmp0eGhoZm9vRE1FVmpJaXdZdnlW?=
 =?utf-8?B?dHlVNFREeGNDUmhRRE5mNmI5WVl5Q0hadTQ4UHFMRGZvelhvZmNHQVd1amly?=
 =?utf-8?B?RWFpSDdpai9UbUJKemdCcVpkcitSQ205WWVUdkR5WGVmY3ZtRzdLQU5ZdlFO?=
 =?utf-8?B?ZXVwOERTcE4vMWZwS1VuZEZQZCt5V0FNdkxxNlBFTkljMGNkeVNZMm5xWk1o?=
 =?utf-8?B?bmoxYWsvOW9nYXN0RlJPUjhDaWswZFpGWTJQa1B4RHlFUTRIMkRDbzFVMmMy?=
 =?utf-8?B?TktualFEV2h3OWVYN1hoVFFnMlA1aTVnTGJJVDE4ZVpwTUp5akVadURTc0s1?=
 =?utf-8?B?TmJhYXQwUUxCQ2Y1NEpWSkhGU1I4QUsvVlh3WXVjVzZleVRqeVBjVW9Ccm04?=
 =?utf-8?B?SEdEellmQVNuQkFMc2VpWTZvYUV0Z2RSUVE0Ry9lUW8yUUhrbnhWODBHYnd0?=
 =?utf-8?B?SWdiVEdoWUtNbTNZKzVuSHpyR3RUdjQ0VG8wTmxQWUVianQvQzZ1VSs1ZFZX?=
 =?utf-8?B?OHc3RzRXV2YyejlMMUE5aS8vTGdpRkcyRzN0Q0Eyc2J2Q1JyQ05GTlFsR0VY?=
 =?utf-8?B?a2VHRmFiYkR6Y0R1ckNmNWhlbit1UE1XRDJWb3N1MWU3Y3F4ek9HMFpHUnJs?=
 =?utf-8?B?bW9HVEtaaHJ4a2x0UjhSM3hWNElDT2Z5OHp4YXFEWWVaNWxUK0MwZnM5VWlI?=
 =?utf-8?B?T2hUcDBuY3NlL0JPY29RQXo4ZzVpbGp6QmxQd092WW92Q3huRVNueEYydThn?=
 =?utf-8?B?VFZtdnRRMEN6WWNnYkYycDU1NnFmT2owQkplNVVVSFVUYXRqZlVNZFBKYXFi?=
 =?utf-8?B?MTJBa21HYW5ScXNsdm5QOHBiYWJtenFQRTVCNFprcmc2eWpYQ1Z6M0JKTFk3?=
 =?utf-8?B?R1IvdUtnQUFBZmJpSGlhS0drVVRqcXlLSmpGMmJtU0E1ZlFOMmg4eDFCdmQr?=
 =?utf-8?B?akZaNmx5WXpRcmJtbFVPL2UvZVhmN2NCRWc2dElkODBRekE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUZDQjRsckJsOFVKQzhHR3NYR21EOHNTVUJYaXNIeDR1VmVYQWRyVVlkeG9p?=
 =?utf-8?B?a3VFTmxGTkIrK3oxaS81SXRFWjlMaExnT09TeGd5anJNUmZGb3hmVlM3b3U3?=
 =?utf-8?B?NWJEWmJrelhaSHQyL0c1c2U4ME9ueWdkZjByYUF2akJoc2Z3UklrdytKTHlT?=
 =?utf-8?B?dXozNHRsc3g1MDVUSmxDdlgwQm14ZHM4d1FzWVFPYW5TMk9idmQrRkFQUWpU?=
 =?utf-8?B?OG0yOTY4a2VyUU1MRWxOWDZISUdpdTlzbGlvZFIwdjNHU2xBK2FJdVlQYzNz?=
 =?utf-8?B?YUl2OU9VeUtoMmcxR20wNXh2ODJjclRXblBnQWo2aWpSUWVrVW81cmdvM1hC?=
 =?utf-8?B?WktYd2ZGNUwvNU53WTJOdXYzc2w1SGhuOFN2SFFOYUc1VXh1N3F0WDEyWW9l?=
 =?utf-8?B?SUlHOTlIeStkamVndXVaZ3FTaHg5WUxtVHNORlROTzZKYnhYSkEvTVZobHZt?=
 =?utf-8?B?bmVITUxadjNzeHcvNkpiNENOWndQN2EzMmdxcC9LSnhaUElZUzZwMkxuWXdL?=
 =?utf-8?B?UFdoR2JRQVlCUGxUUzhPU05XdUZyYmkrUDBNYjk0WkQvSWZRWVk2L0hvWUEv?=
 =?utf-8?B?MEFMOHRqMlk0TU0rQUljQ1UxYnNuTzh6dXk2cEM5bEpqdDY0OTZtcTkySGEz?=
 =?utf-8?B?U2t5bkN6b1UwVUdrUWxncFlCdWwvekJvUnp5OFV6Zk9HVGNQUWVXOVg5cU03?=
 =?utf-8?B?MTR3UjZmalp3OEpmbGttT3N1VnArVDY1UFo3SFk5T0JmQytWS250ZnVpL1A0?=
 =?utf-8?B?VFU0R3JkZ3FYZTRDZURrYldId1hTcVdLSXVkVE9VazBxZzUzSWV2RkZxbGt5?=
 =?utf-8?B?S2NiRlQ4eFltMXpiT3FxaDVzMVJvU1NRWWs4Ui9EUjZKaGRWZ0dkUXNWVThP?=
 =?utf-8?B?dlRPZW9tM1Q1TWZncW9JYWREWThiOXRoYUlvbkNwcmNkMmphcktkdnl1VzB5?=
 =?utf-8?B?Z21PUTZhelQ0TUFiVmhYTkdZd2xnNlNLVW1Lc2JUZ1Q5OXRmUW9hM2NnMWxL?=
 =?utf-8?B?dVQ1UXNtZFIwV3p6a2lIWWxISmJmdVRXcUFiYmFIbmF3bURqeG1rYlRPS0JV?=
 =?utf-8?B?ay9PdTdOZkE1MmJ4ZnpsQkJjNitUNzBicE0rdFlwZDZ6bFJtOVlBNDRuN0g1?=
 =?utf-8?B?UUx4UEdMVm94d2FZMTZTR0VhZS9uUDNLZkkxZTRIOWR5Z2IwaEdRY0ZSQ0No?=
 =?utf-8?B?akNOZFVSTkNZSUFGenBKbVErYnFPUEtyODM4VE55UndqdzBnQjZWTTNWSlQ0?=
 =?utf-8?B?VzI1NXMwMlRCbDBaMWtCcEhYNy9xZ1V6VDd0L0ljUTZyU3V2NmRJdExrT1B1?=
 =?utf-8?B?N3NpQzNBNTJlUHo0RTFzMyszV3FReHlVcE1iS2ZPVEVoK0dEdWduRFJVMW13?=
 =?utf-8?B?NmpOZEhzMFR0aUlGTVdVUzlMRGN3VEt0Qk9lY3U4RElMbHdLSll3d0c1eHF6?=
 =?utf-8?B?UGEwMzFqSmJnekxWVE5tSXVZNVhPV0kza2NEMjYzTU8zbFRSYVhPTGE2OFlz?=
 =?utf-8?B?YkhVS1E4M0dmUi9QdjFTTzJ1WWVidU5vREJMTWlJVGNrdmdTZ1BDckZYb0ZM?=
 =?utf-8?B?QS9hVlFwY1dhMUQ5U2NGZU81cmlja2owRG1pZ25vSll1R1B5c1pUOGdZdVF6?=
 =?utf-8?B?b0hOakNsZUJ0dG5TcE1HM0tpdlZlUjY5L1pQQzRpZGFEWlN3cC92UU83WFdH?=
 =?utf-8?B?SUNkUG9LS0dIR3dWSFdYeEV4V0VDWWZwSngrZEJoRGNOUlpzMGxRclEzbFd1?=
 =?utf-8?B?blVvMnlveG9ockFUbzR3R3ExVnQ5TVZ1MTgwandyd3ZTWXppOGxwblJkOGVz?=
 =?utf-8?B?Nk1PbUR4OXVYa2RFWSt5QXd0YmpZa3lNT2NSc1UydVN1blB6YlNjcGZFWFA0?=
 =?utf-8?B?d1EyS1phekxKUTFWRzlUT3cwUmNTUTZ4WGNOWGJOWmo4OGRzOGw3Z0dCSHN1?=
 =?utf-8?B?RlRwRzBxanlwTXdmeGwraUpCNE01OUJDQ01JNDhoRkwvaHFib0V5RmVwR0Mz?=
 =?utf-8?B?dGtvUEpDS0t4MU9TcFFIc1FSR0hhRXByRVNXZU4yWTdwT0dYVWhGdGlYbmZa?=
 =?utf-8?B?VDVXeFdMYVhmQVloNWwvcGdHSlBLdFV6NERjTTd3ZGttMXFXSWwyTWh0dlFv?=
 =?utf-8?Q?45xO3PK2AEaEG09+cxg1jClsQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39F1FC3CCF45D645BD607CA6053D1579@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T5Wlb7SAoXR+LvNi9PGxvLk4wJTwKW/q1zY+fAOdw+x2HEldFKhlHPFTtjJYDfRi7SUupoTICmWx5NhxvTd0usxn0GYa4uBpSz3h1u8igFFkX60/7BwZ5pu1+oYOQeydYY1SeY82b8fxdxn3tJ1zrMabypRquMSwXSYg3aCtywMpUP8Tal4GF/KdvA2t2YNleXm8PhE40jWF95soX1iedzh2sliYL/ZKoK4jNYtCBvvHvBxzOs2yoCCcLD0W9uA1RiflCXxb6YZp53ZCcLzMonKJiEbd5DdnknjcnSOIjfOBFJxfLc46wL93SkCpmUUXUwUDo5tfInQ/nqX6Fh4HROps+Lbw1eZRaxgelkxmh7xSMGKJfbRGIYU4J8L+PHvtlPmzIn2lKhxcC4w1bVNstBYLKosNFDNRudflbkEfTKGUgEuS2/NexdrnunSn7oyLVoHghamLohUbFXFCkVc66h1WBZX8dWHwPc/4gmF+9GBdIQoM0Ck5skr9u5bJYADrTcxLzcUoBmx/H55B/R/ZQ2EIVHRLewdoyu2WBMHFZPXNLwxKtN3fi6+I3lZMBjpGcoKrTojUiMfMxPQHlbcClobnIt56nEDtmGMr5Zvz9ERp13DTWzcqOhYph7LPjk/IIigax+QeNvqTt+zXqxnALg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbd4a2f-7e7b-4814-612c-08dd13346bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 00:50:02.4268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tkYbQYAyxt2HZQf5Rw6FyAZ41pr/lVXUsl2JK9e2sBSl19g9yixpeQpgc/5qvdUNvXMYyld4M8yYv2FTKHz6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
X-Proofpoint-ORIG-GUID: JXgR71pF4rKp0R3Efl409YkUEB2mEXp-
X-Authority-Analysis: v=2.4 cv=a5zK9VSF c=1 sm=1 tr=0 ts=674e55c2 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=xzUUtdq9cjXk8XfaoP8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JXgR71pF4rKp0R3Efl409YkUEB2mEXp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=675 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412030004

SGkgUm9nZXIsDQoNCk9uIFdlZCwgTm92IDI3LCAyMDI0LCBSb2dlciBRdWFkcm9zIHdyb3RlOg0K
PiBIaSBUaGluaCwNCj4gDQo+IE9uIDI3LzExLzIwMjQgMDA6MTUsIFRoaW5oIE5ndXllbiB3cm90
ZToNCj4gPiBPbiBNb24sIE5vdiAyNSwgMjAyNCwgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4gPj4N
Cj4gPj4NCj4gPj4gT24gMjUvMTEvMjAyNCAyMDoyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
Pj4gT24gRnJpLCBOb3YgMjIsIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+ID4+Pj4gSWYg
Y29udHJvbGxlciBsb29zZXMgcG93ZXIgZHVyaW5nIFBNIHN1c3BlbmQgdGhlbiByZS1pbml0aWFs
aXplDQo+ID4+Pj4gaXQuIFdlIHVzZSB0aGUgREVCVUdfQ0ZHIHJlZ2lzdGVyIHRvIHRyYWNrIGlm
IGNvbnRyb2xsZXIgbG9zdCBwb3dlcg0KPiA+Pj4+IG9yIHdhcyByZXNldCBpbiBQTSBzdXNwZW5k
Lg0KPiA+Pj4+DQo+ID4+Pj4gTW92ZSBhbGwgaW5pdGlhbGl6YXRpb24gY29kZSBpbnRvIGR3YzNf
dGlfaW5pdCgpIHNvIGl0IGNhbiBiZSByZS11c2VkLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9m
Zi1ieTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5vcmc+DQo+ID4+Pj4gLS0tDQo+ID4+
Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgfCA4MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiA+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNTUgaW5z
ZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYy
LmMNCj4gPj4+PiBpbmRleCBmYWQxNTFlNzhmZDYuLjIxOTIyMjJmYWY0ZiAxMDA2NDQNCj4gPj4+
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jDQo+ID4+Pj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9kd2MzLWFtNjIuYw0KPiA+Pj4+IEBAIC0xMDgsNiArMTA4LDkgQEANCj4gPj4+
PiAgDQo+ID4+Pj4gICNkZWZpbmUgRFdDM19BTTYyX0FVVE9TVVNQRU5EX0RFTEFZCTEwMA0KPiA+
Pj4+ICANCj4gPj4+PiArI2RlZmluZSBVU0JTU19ERUJVR19DRkdfT0ZGCQkweDcNCj4gPj4+PiAr
I2RlZmluZSBVU0JTU19ERUJVR19DRkdfRElTQUJMRUQJMHg3DQo+ID4+Pg0KPiA+Pj4gRG8gd2Ug
bmVlZCAyIGRpZmZlcmVudCBtYWNyb3Mgd2l0aCB0aGUgc2FtZSB2YWx1ZSBvZiB0aGUgc2FtZSBy
ZWdpc3Rlcg0KPiA+Pj4gZm9yIHRoaXM/DQo+ID4+DQo+ID4+IE9vcHMuIFRoaXMgaXMgYSBtaXN0
YWtlLiBUaGUgc2Vjb25kIG9uZSBzaG91bGQgYmUgMC4NCj4gPj4NCj4gPiANCj4gPiBPay4gUGxl
YXNlIHNlbmQgYSBmaXguDQo+IA0KPiBZZXMgSSB3aWxsIHNlbmQgYSB2Mi4NCj4gDQo+IEkgaGF2
ZSBhIHF1ZXJ5IHJlZ2FyZGluZyB0aGlzLiBFdmVuIHRob3VnaCB3ZSByZXN0b3JlIHRoZSBVU0Ig
d3JhcHBlciBjb250ZXh0DQo+IHRoZSBYSENJIGRyaXZlciBzdGlsbCBjb21wbGFpbnMgd2l0aCBi
ZWxvdyBtZXNzYWdlLg0KPiANCj4gWyAgIDY4LjIzNTExMV0geGhjaS1oY2QgeGhjaS1oY2QuMC5h
dXRvOiB4SEMgZXJyb3IgaW4gcmVzdW1lLCBVU0JTVFMgMHg0MDEsIFJlaW5pdA0KPiANCj4gQ2xl
YXJseSB0aGUgU2F2ZS9yZXN0b3JlIGZhaWxlZCBhbmQgc28gU1JFIGJpdCBpcyBzZXQuDQo+IElz
IHRoaXMgc29tZXRoaW5nIHRvIGJlIGNvbmNlcm5lZCBhYm91dCBvciBuZWVkcyBhZGRyZXNzaW5n
Pw0KPiANCj4gdGhlIGhvc3QgY29udHJvbGxlciBmdW5jdGlvbnMgZmluZSBhcyBpdCBpcyByZS1p
bml0aWFsaXplZCBieSB0aGUNCj4gWEhDSSBkcml2ZXIuDQo+IA0KDQpBbnkgZGV2aWNlL2Z1bmN0
aW9uIHRoYXQgZGVtYW5kcyBubyBpbnRlcnJ1cHRpb24gYmV0d2VlbiBzdXNwZW5kL3Jlc3VtZSwN
CnRoZW4gaXQgbWF5IGJlIGFuIGlzc3VlLiBGb3IgZXhhbXBsZSwgVGhhdCBtZWFucyB0aGF0IHlv
dSBjYW4ndCBzdXNwZW5kDQphbmQgcHJvcGVybHkgcmVzdW1lIGluIHRoZSBtaWRkbGUgb2YgZmls
ZSB0cmFuc2ZlciBmb3IgTVNDLg0KDQpCUiwNClRoaW5o

