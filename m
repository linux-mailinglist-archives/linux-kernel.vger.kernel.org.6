Return-Path: <linux-kernel+bounces-277133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AEB949D16
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3690B1F2172F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4021E519;
	Wed,  7 Aug 2024 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D31ameO1";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="g8j8AfGb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ShMA2a0S"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7517756;
	Wed,  7 Aug 2024 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991107; cv=fail; b=RGxlCpIjKSlGZlaGckVrLT4oIRiSN3oQu008eJLvVbKNS7i5p8zs7qMdfG+xUYddxSvxwRp1nef6rfhz/dCz5UG3dQ3270+9AAm9JObO+c0qNluoB7OloVEJa7wdldtoQpwEaqiQNZ6asmbg5VB60iB2Bwz7WEl26arSzXdYZfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991107; c=relaxed/simple;
	bh=UsLnszkBtSgGcPCQ0CDsIQdMW76e/Z9tdDCsLg4UahQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kb1/sKdw6Wb2fMqNtroc/F26Ut/TPQJBrx/bm1MSYW2iRWpz91m4OYA05gPM9/66j4GkWHqZyifuGNRgNYxn+bcmqO8dT0vsFoMkRhzR56ybpFpLYCMouNUZbKtQuCh6nvhgL7L+1qPKc3zrth2NrxDW7bw5WdH1yxCkjdV5ntY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=D31ameO1; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=g8j8AfGb; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ShMA2a0S reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476MJhFE025827;
	Tue, 6 Aug 2024 17:38:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=UsLnszkBtSgGcPCQ0CDsIQdMW76e/Z9tdDCsLg4UahQ=; b=
	D31ameO1LW+mg8M1ahTrqUr4+HobBsD+PD+kHVs5AP9cAgDylCeXunKPmlJHrPDt
	R5numvpgdbXA5Zmej1GEG3xIdwl0m2ET9xz6PXqZM/RR965EUZ+OcpenqTvmWnIu
	ZeJfTtaTPvCrhoGAOmRrLaSGGk8aUaFzWLSyqm9dkC9g3GP5xqoj1cTKHONUCDJl
	wCcrWpVkXSNhNF8RBZ8GCMtchmkh6Sh1QFfB8i1gzwhXjpjmUFNs24NgLgVfkKmz
	kdxGsY3QlrEv51UsAFehawOWY84QQAIJvZvV35dtQSrWvM91fcGGtj14jY9Yek7x
	mp0ziwjw4VmVQP5s9Gdz2Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujb8jw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 17:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1722991099; bh=UsLnszkBtSgGcPCQ0CDsIQdMW76e/Z9tdDCsLg4UahQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=g8j8AfGbQiBmGYQUezhbEOTdKJ3yAgAvYKq5LEwJ4N1OtHL3mH2vw2iri9A+mJ7Gi
	 di9FqrSHjoGkD077mn4sFDcY4t8mL3EB3QxN28F6iPaNQKVpF1/igFojH4MmWM8unF
	 9Z9Pxmyj8TSjDxPmpBmsBSPcQF0cvukPUGda5aevpkbVYXrRO47lrFTU3XufmC4k6h
	 ZErHr5YMwvNa/imKZASTGDm6n7sSd4AL4ZTmTKg/QABcGmOVXONpuORXAg5YVm7nnR
	 AIe36/5YW5nC1M1PWwnIuKh45HjwWvQpKsHsCJYovPqJmHvuzcKBIzzSx4risN1tfH
	 quEDAD1zBKspg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D99024028D;
	Wed,  7 Aug 2024 00:38:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 44226A00B8;
	Wed,  7 Aug 2024 00:38:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ShMA2a0S;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5F27A40362;
	Wed,  7 Aug 2024 00:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djgkdU3l87pPtF/0EoXNQ+T+UcjKBXeWipTvbtmW7iNNaIx6rxomeP3t/RDXBHdNJ5Gtnw9KdotTZj+zemvNMAUJdER+l+gJJBJeWAaTxisweYzJshDuTFYfNGiWVKYeMBJl5ht4vlJ1ZsQ9UZYNL9agK+HBXfVGk8bkmvde64lJoPvqcHw3xBbMoi0H+euGtFoHgd41dOIH/5ornIcP2W+ry8qv35UhDTstpoRm3mQDmGLjAyhCntJ1f+vKv2KFRzz9C9y5XQy1fKS6I/CSryohxxqXuMBBIUPaIFna76qhDE7ohIOH6oRoAPk7EZDvTljhITaQ+0b+UOwJofQ9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsLnszkBtSgGcPCQ0CDsIQdMW76e/Z9tdDCsLg4UahQ=;
 b=RRSlhz4G0fs5QFTF2UTuFmzNrfagpefBPhSsY4FKIc8XXRniwN9fVBlT42v/0hFlYxBjNkwP2Pv6v7Z/k8iNHnDKuVYe+EnhRTQJ6PH+Y+ZPDwx/kj6UCIx4qwpFqSoQMaoOkpshDn9fBtgPl8rlgTGCK1ulvTj/lsb9bOMHefhwmvr8lnH30vMwXQ9uCXMyLG84lnaX2QySkKg7xWivqT4bqxZx3kUfL67Kx78dbCy8UYI4p8jHfN8us2RPBvMsnV+tejyI7NZ6Lp8SKEMayFyOD/tWfLpvG9fsubcnteFzemAKj0kYB9wLmepFEdgMYZKWk+b1L7cVWXNQUu95EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsLnszkBtSgGcPCQ0CDsIQdMW76e/Z9tdDCsLg4UahQ=;
 b=ShMA2a0SmzYpolH8XZxlqKeFSDcRtydnFxxS6e7ViUoWOZ3PtUEzU0gZwoAQpeqqorC9oaKO4eELZovXhmAEaQLR1T4InyymYnEDq+Zsn8CdmpQ7XVpPcSy7aGC/5TmKckMwYDl+BMx3/HKKS9ubI+6XowM/YtCiOE66+nU7fNo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 00:38:11 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 00:38:11 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt storm
Thread-Topic: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt
 storm
Thread-Index: AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwA
Date: Wed, 7 Aug 2024 00:38:11 +0000
Message-ID: <20240807003806.5owtgwgw2lczg4u5@synopsys.com>
References:
 <CGME20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2@epcas5p3.samsung.com>
 <20240719110100.329-1-selvarasu.g@samsung.com>
In-Reply-To: <20240719110100.329-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB4054:EE_
x-ms-office365-filtering-correlation-id: 94e33184-2d91-4a05-13f0-08dcb679374d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkdSZjU2NzFDcXYvV1RaV2RDZ0wxbE1Ib20zZDJmL3pJKys2VHREcWJCRVZG?=
 =?utf-8?B?WDVrMnR6bXp2ekx5WEdBaTVnQ05NRFM2d0pwMXFmRXRkcStwN0VQZHZQMmFD?=
 =?utf-8?B?aU5IeCtqaFo0T1JDSXpmdS9WRVhxczllZmNHZU5vbEVxdHByem1xOTZDZk5p?=
 =?utf-8?B?WmVRbHZhalozb25pVkVncUxVR0lTTSszSUIrMTdFTENkVmY4TFp5eVVwc2hk?=
 =?utf-8?B?aUZSTlRoY1pabHNGRkFPcGZleTZRcCt6SWMzdTBYZkhqc2QrdzhzT29GRTZF?=
 =?utf-8?B?bWVVcHJzQ3lla3F1aG1UdXcxSWl6UFdoQXN5cENUL0RieGQ1VDlCZEw2Y0Ra?=
 =?utf-8?B?SzBzYXR6SCtjcnFsWnMzc0lnQkhURXpKNmFWeXhXNkJpeUU2Y3VsUU5TYmJV?=
 =?utf-8?B?ZVpGd0w0Vlk2eExtMVdkV0JMYkZrMERLZG9IL1d1QWVwRXJ5ZUpLbkhNQk84?=
 =?utf-8?B?SU1USjNKWXF1Ky8yYkpIUCtLY3phSC9xc2JNZjFFSE16cldMUjNNMjhxbjVy?=
 =?utf-8?B?NG0wWlVaNmJIbHE3Ry9FSlpBZlJlRWJmc0hzSVNMS3ZjVkdNWkxLOWJVUVdD?=
 =?utf-8?B?eTYvV0cxbjloS3NvOHI1V2VsMVhNRTFnc3BlNHB2ME16YkxCb1F3NUh2UGx5?=
 =?utf-8?B?dit1ZnVYc0QvbmtoeEVyRlR1bmZ1Z2ZsUW4vbjJpL0VwVW5SaXc0K0xmQUQw?=
 =?utf-8?B?dlB2eFhKWXFZemVMbTF1V0p4UjBRVlpWaTVXRE1KeU5yV1JtNmtCdGNZc2pj?=
 =?utf-8?B?Smh0TXdLSTV2TWtJMDhZNWlvQm5rR0UxdHNqOHBVS2pDQ3VnRExZdC9SY3VK?=
 =?utf-8?B?dzBKSldVVFhQUEFCSEZsMXpINnVkelg1N29NNzE0YU8xYzFwZWhUOFh2VFJW?=
 =?utf-8?B?ZTluNktPaXVNVE83c0REU3NYT0F4L1Q2NzRqR2w3cEd2STB6YjdURGlDYStu?=
 =?utf-8?B?cWtLbS9UZXF1b2owQXNSelQ2MVN0eGdXYTB1SXRqZTNBVmlTbkdjWHhNaEFv?=
 =?utf-8?B?elhzUitQc2pVK1pEWW85SGtDOXNkUEoyRzdaaXRnQ0JQb0loc3NHQ3dnZEVM?=
 =?utf-8?B?SlRXZzFBcTJGYjFaRnZZNWFKUTMvaXF3Q05SaWlNQ1o0OEVzT2J5TW5vME5R?=
 =?utf-8?B?WnB6a2RsbkdhQndFUWJKWU1QaUxLaE0zN3BDRGxacGRGQk8vd1pBTXVUMWR0?=
 =?utf-8?B?Ui8ydEtBRm1PYzF1QmlBWDVyL05oS2c5U0t3bXFqeHRwb2Jkc1VYSFduSkM5?=
 =?utf-8?B?TGhpTEtUMndQQTF6czl4aE9pSmxqWG1qTWV2QUhBQ2M5cGlpTlAxWi9yanVw?=
 =?utf-8?B?ZGlWS3M4ODdaL2YxQmNadG9OUjdKL0F1SG9xcjdtLzQ5Yzd3RGt6Q1ZYVHU2?=
 =?utf-8?B?cUc3OTBJR1BWNmM4K3FFdHhBOWRHamVQUlo5UXdzR2lad1g4YWpWaVpMVjZV?=
 =?utf-8?B?RkRkQ1Y1MGpYeUhxdUE5VGhOUkw0UWladVdXcDFvcG85a3liai94LzBUSW1P?=
 =?utf-8?B?QlMrZWZWUXVQVDdqMTFKbDJSSlFoSER2cncwUlZ0RnB3NVVYZG9QaHlZTWFm?=
 =?utf-8?B?elRhZ3ZhYlFObDkrUFhMeG5lbHdweS9xdUdXUG9MZVRMYllCME90NnQ0RU9V?=
 =?utf-8?B?NTN0UG41blEzWGE5U09mK3QwaWk4QUxMMGc3NldjVGhtcm9iV0RnQ3FpSmUw?=
 =?utf-8?B?RkhyaVI0SjRyei9nbmxkNlE5ZDN4MlFhN0E5UThKa1Z1QkpwdGlHUXlaQ0lZ?=
 =?utf-8?B?OExpbVBHNW9UREZ2SWFHS1VKdFpGa3FFNWZiNFR0RDlRT1hUZ1Y5RGlYNGNa?=
 =?utf-8?B?R3VFdndXRldkaXREeFFtRFBKMWFzbGxsc1lVazBuZ1NrWVV0UG1nL0NqY1p0?=
 =?utf-8?B?MGJaRzVhdVdOTXlOQzZlVkJDcWVIWWsrV0N0aXF3cmpyUFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTMyVDNvVWNpSUZIaU9pUkVvN0g2dm1KZVRvSGVnQUJBQVRHQ2p6UU83U3hq?=
 =?utf-8?B?ckJ4UnU5M3A1VzZsbDBkM2M0MWNGYmFGYlcvNXlqdU9La3ZhRHVYakM1UUVq?=
 =?utf-8?B?ZTJXY0Mrc2p0RXdrYytycGFNdnpYZmFNT0R6MGhIVGJId1BDcTJOSjdOWGV0?=
 =?utf-8?B?a1BjTlBMS0Q2dmpxRDNPcUtUT0NYQ0k5NWpoMVI3UlpJT0l6SVFxbjI3VExs?=
 =?utf-8?B?YnIvampxL1pYWGYrVDU1WjJVVFNNcTJsaG1rT1UwcWlqTEZjQkFJTllldWlN?=
 =?utf-8?B?MVZCUDUyWHhZRVdNeExHMGl2SndBaFdyWGpuTjRHbHAyZnBJWHZKQW1pRGRm?=
 =?utf-8?B?a0pjeWViK0V2SFdBNWUrcGJsNS9kYkx0dGF3L1pLZVFrNEJHeEF3dFowSWZF?=
 =?utf-8?B?S3hRb09xS2VJMWcxcHZsQ2RDUEt6aTdpQ0krMmEwMWcxVThXa3Jva3pQSzRo?=
 =?utf-8?B?YW90a0FDUVMvWno4cnB2cDRQODdId0wvRGRIT09iRGp3bEhzaElVdGZNVGVV?=
 =?utf-8?B?ZXgrMDduZVZqcXpoMWYzSnFCaTh3Qm9vTkNhNkVVWjBPWkl2aVVMNEVUdTBN?=
 =?utf-8?B?MkVwTGpMKzJUNGpMN0pTcE9BUmlQRk9WYUFvaER4Tys1b2M5S2tZdVFzMGgx?=
 =?utf-8?B?aHArV2VLUG5IcmdJV1VPbEd2blNwcTBkL053eXpCWWkzQWd0V25lSkR3c3ZG?=
 =?utf-8?B?bEpwbzBwTWl0ZFZWV2NuWWFOak5ZMlNwdS9ZL0lONDZ4NVh6cW9JYVUwY3dm?=
 =?utf-8?B?Q1lOaytmdTBGdFd3K0RUeTE1STZ6NUwyOXRGRVdSNHptOXhZQ2ViOWViMytl?=
 =?utf-8?B?bWg2SFYyYXdFbUQ4TFFFY2NSbHc2bkY4ekp1U1NUdGt2Z0xub0duTmdRd1o5?=
 =?utf-8?B?RGYrZVNPV3FBZTNwOUp6aFBDYXEyTlFYaU5ZaXR0eVl0RjJZWWdFZTZPak5D?=
 =?utf-8?B?dElGOWd5KzJsUnV3S3F6YWFRVTlEdFczYURESjRvWE9wdURVZmhMeStLQlZO?=
 =?utf-8?B?cmNUL3FGbDh1aWl2SUhUL2x3Q0ZaWGxQQTZMQ0R0VEJydkV6U1pWc3VieGVa?=
 =?utf-8?B?bTJNZHRwdWFzTjJzcDFMZlMzT2hqd1dSSHVpUnNaTnpralVaUWtGbUR3cFc0?=
 =?utf-8?B?MllZZkhIa2JYVTNGWC9mWEVscnR1c2J2bXVkMUZVQ29RbVhVYWFqQzlDeUxk?=
 =?utf-8?B?SjdQWkxyTC9GbE8rdkY5ODZSai9FVThTc0ZyUEFROGVjUW9rK1BZazVGSTg4?=
 =?utf-8?B?aUVZYUo2aWpDdWdaVHZtdXB6RjBZUkljUlRPRXh3Mmx1bnhxTGhNbFIyc1Ur?=
 =?utf-8?B?clBCVkZlVTdrL1hjWVpNTDJaZDhhaHQ1TExmeW0vVnRRakNscitGdHAwV1Zr?=
 =?utf-8?B?VWUyMDJGWHhveklUMmVTRkczeGVIa01TelJsT001dEtXQ2FzNFAxdmtJbytW?=
 =?utf-8?B?ZG5VK2M1ZW51V05jRXB4M3RpeFBHUy9YNzRwVVNSelVtRnRmQWlKRlUxakJ0?=
 =?utf-8?B?d2JHRDkvZENtdHkzOW1WQ0V1MnhKNlVmQ1FOQ09QT29lZ1l3WTNET0ZXNEdK?=
 =?utf-8?B?NldZQldxeVBISTE5WVM5enY5dGltb1g4YzI1dnR4Y3drbTc3SzVsV1pSdGpM?=
 =?utf-8?B?OG9hZ2xqOVNlbUIxWjlZNEZGNDMwR0VDYllyMWtEQlhiMm8xLzhycExDV1dq?=
 =?utf-8?B?SXZtb3VGOGxrQXkvckk5WEVlMGxUdmVRemI4L216REVTdmg3OUdJOWFSemFR?=
 =?utf-8?B?SUVqaHJ0dEZNZUJ1N0dxYTUwaFlGd1EvNkxHR21Ld0ZmME0xeHN0TDNLTU9y?=
 =?utf-8?B?dmVPZndscjBaN1dTMnp4MGE2Nmt4N2R4MzZLRDFhUXRjdysyOFdzVW05eVJn?=
 =?utf-8?B?QzFhSS9GRFo3NmVKQXBqaWdBVEdYalF3Q1RmZkJLWWQzbS9KaVZ2ZC8zek8w?=
 =?utf-8?B?Sm5hQi9hSWtXL1QzbXBBeElPNytpZDRscjdsdjdiMnJHeDM2Rm1QR3duODl2?=
 =?utf-8?B?ZFFobThLZkpHa2tXN1JkT3NQOHo4ME1XSWE3RWY5Z1paNytUTkVjc1V5ekgy?=
 =?utf-8?B?ZkVHZUlncVJNQjZ3UzczWjgzWUR3dUpsWFdoL3FKWFQ5bGJKRnNFWnMydDN3?=
 =?utf-8?Q?jEY4gpvelapx9vofEN8aJ4v2J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42C3EEC588C9314B9BBD706575AD452B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NVuq0HJWOtRNRdeHpcP6PMuk6ppfNcGLQZ9SYqclUg4GMc6HUW+H0+YX5UIfpgqW8jgJx33XaKl0g0ab2aqj96Jq803k4J5084lhty3rtEUbn07JWIDd9bPz5HblzmSKKHWQM3ATGbr/Y5lACzWrIxvF9tYiHnu8GlWVBqZd0Zs5wF8TS1QxhWx0AbmzN/2kfRVuqKGN6a4wBt6TZBVFlwUPSP6yG9jy0pr2/SDFRpwwtD2dmgNxcB3lRjhFSUgu3g6caAKCBn6SGcJUawlaBP2YmiH3lt3nGKFmVU6ktT5ezg02weZWYdJGtxGhsyK1aP75hxHt/XECsR2tOgIh3iK5otiPibq4BG1ABa393MJsDsle9yuc61VCh3QzXFdWNWalaiep1LA0won7MuYpkqhG21AfbivNv0S3vmNRZmPiqof+J4Hb/q7um094l5nXmVsLF+NMxk10F1UAL3+CygEV9TYz7VwOcCv2z467tkZw3xwV6UfWwm+wM1mmVV4cF3aafIuNie012XLQdDi5lV6HmCB2YZkMfKLoc3b8H0sHNQAMHqoaHiOdeJVJaj6lznLBdGPIbXi1oJQcoFzQsSl1c9rbyKzVAwFBlJJBXa/6r0JGSnqKxLcPtf1XJO9HPGJRbSUx6laNhuaVRn0dfQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e33184-2d91-4a05-13f0-08dcb679374d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 00:38:11.4257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDerD5GUx7Ot6UPq1kvPAZAK8XrOqx/a3jlZvOfHkM0CZ3NLUmU5CrrK6GwhC/qCNcttE8zSYjVHVn3F5Ywdgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
X-Proofpoint-GUID: -gNNXp0mbdzcr-Gwk9gszlxtkQzRiWop
X-Proofpoint-ORIG-GUID: -gNNXp0mbdzcr-Gwk9gszlxtkQzRiWop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_19,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=976 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070002

T24gRnJpLCBKdWwgMTksIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBJbiBjZXJ0
YWluIHNjZW5hcmlvcywgdGhlcmUgaXMgYSBjaGFuY2UgdGhhdCB0aGUgQ1BVIG1heSBub3QgYmUN
Cj4gc2NoZWR1bGVkIHRoZSBib3R0b20gaGFsZiBvZiBkd2MzIGludGVycnVwdC4gVGhpcyBpcyBi
ZWNhdXNlIHRoZSBDUFUNCj4gbWF5IGhhbmcgdXAgd2hlcmUgYW55IHdvcmsgcXVldWUgbG9ja3Vw
IGhhcyBoYXBwZW5lZCBmb3IgdGhlIHNhbWUgQ1BVDQo+IHRoYXQgaXMgdHJ5aW5nIHRvIHNjaGVk
dWxlIHRoZSBkd2MzIHRocmVhZCBpbnRlcnJ1cHQuIEluIHRoaXMgc2NlbmFyaW8sDQo+IHRoZSBV
U0IgY2FuIGVudGVyIHJ1bnRpbWUgc3VzcGVuZCBhcyB0aGUgYnVzIG1heSBpZGxlIGZvciBhIGxv
bmdlciB0aW1lDQo+ICwgb3IgdXNlciBjYW4gcmVjb25uZWN0IHRoZSBVU0IgY2FibGUuIFRoZW4s
IHRoZSBkd2MzIGV2ZW50IGludGVycnVwdA0KPiBjYW4gYmUgZW5hYmxlZCB3aGVuIHJ1bnRpbWUg
cmVzdW1lIGlzIGhhcHBlbmluZyB3aXRoIHJlZ2FyZGxlc3Mgb2YgdGhlDQo+IHByZXZpb3VzIGV2
ZW50IHN0YXR1cy4gVGhpcyBjYW4gbGVhZCB0byBhIGR3YzMgSVJRIHN0b3JtIGR1ZSB0byB0aGUN
Cj4gcmV0dXJuIGZyb20gdGhlIGludGVycnVwdCBoYW5kbGVyIGJ5IGNoZWNraW5nIG9ubHkgdGhl
IGV2dC0+ZmxhZ3MgYXMNCj4gRFdDM19FVkVOVF9QRU5ESU5HLCB3aGVyZSB0aGUgc2FtZSBmbGFn
IHdhcyBzZXQgYXMgRFdDM19FVkVOVF9QRU5ESU5HDQo+IGluIHByZXZpb3VzIHdvcmsgcXVldWUg
bG9ja3VwLg0KPiBMZXQncyBjb25zaWRlciB0aGUgZm9sbG93aW5nIHNlcXVlbmNlcyBpbiB0aGlz
IHNjZW5hcmlvLA0KPiANCj4gQ2FsbCB0cmFjZSBvZiBkd2MzIElSUSBhZnRlciB3b3JrcXVldWUg
bG9ja3VwIHNjZW5hcmlvDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KPiBJUlEgIzE6DQo+IC0+ZHdjM19pbnRlcnJ1cHQoKQ0KPiAgIC0+
ZHdjM19jaGVja19ldmVudF9idWYoKQ0KPiAgICAgICAgIC0+aWYgKGV2dC0+ZmxhZ3MgJiBEV0Mz
X0VWRU5UX1BFTkRJTkcpDQo+ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBJUlFfSEFORExF
RDsNCj4gICAgICAgICAtPmV2dC0+ZmxhZ3MgfD0gRFdDM19FVkVOVF9QRU5ESU5HOw0KPiAgICAg
ICAgIC0+LyogRGlzYWJsZSBpbnRlcnJ1cHQgYnkgc2V0dGluZyBEV0MzX0dFVk5UU0laX0lOVE1B
U0sgIGluDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRFdDM19HRVZOVFNJWg0KPiAgICAgICAgIC0+cmV0dXJuIElSUV9XQUtFX1RIUkVB
RDsgLy8gTm8gd29ya3F1ZXVlIHNjaGVkdWxlZCBmb3IgZHdjMw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdGhyZWFkX2Z1IGR1ZSB0byB3b3JrcXVldWUgbG9ja3VwDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBldmVuIGFmdGVyIHJldHVybiBJ
UlFfV0FLRV9USFJFQUQNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZy
b20gdG9wLWhhbGYuDQo+IA0KPiBUaHJlYWQgIzI6DQo+IC0+ZHdjM19ydW50aW1lX3Jlc3VtZSgp
DQo+ICAtPmR3YzNfcmVzdW1lX2NvbW1vbigpDQo+ICAgIC0+ZHdjM19nYWRnZXRfcmVzdW1lKCkN
Cj4gICAgICAgLT5kd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoKQ0KPiAgICAgICAgIC0+ZHdjM19l
dmVudF9idWZmZXJzX3NldHVwKCkNCj4gICAgICAgICAgICAtPi8qRW5hYmxlIGludGVycnVwdCBi
eSBjbGVhcmluZyAgRFdDM19HRVZOVFNJWl9JTlRNQVNLIGluDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRFdDM19HRVZOVFNJWiovDQo+
IA0KPiBTdGFydCBJUlEgU3Rvcm1pbmcgYWZ0ZXIgZW5hYmxlIGR3YzMgZXZlbnQgaW4gcmVzdW1l
IHBhdGgNCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo+IENQVTA6IElSUQ0KPiBkd2MzX2ludGVycnVwdCgpDQo+ICBkd2MzX2NoZWNr
X2V2ZW50X2J1ZigpDQo+ICAgICAgICAgaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJ
TkcpDQo+ICAgICAgICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4gDQo+IENQVTA6IElSUQ0KPiBk
d2MzX2ludGVycnVwdCgpDQo+ICBkd2MzX2NoZWNrX2V2ZW50X2J1ZigpDQo+ICAgICAgICAgaWYg
KGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ICAgICAgICAgIHJldHVybiBJUlFf
SEFORExFRDsNCj4gLi4NCj4gLi4NCj4gDQo+IFRvIGZpeCB0aGlzIGlzc3VlIGJ5IGF2b2lkaW5n
IGVuYWJsaW5nIG9mIHRoZSBkd2MzIGV2ZW50IGludGVycnVwdCBpbg0KPiB0aGUgcnVudGltZSBy
ZXN1bWUgcGF0aCBpZiBkd2MzIGV2ZW50IHByb2Nlc3NpbmcgaXMgaW4gcHJvZ3Jlc3MuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdAc2Ftc3VuZy5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA4ICsrKysrKy0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gaW5kZXggY2I4MjU1NzY3OGRkLi42MTA3OTJhNzA4MDUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
IEBAIC01NDksOCArNTQ5LDEyIEBAIGludCBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoc3RydWN0
IGR3YzMgKmR3YykNCj4gIAkJCWxvd2VyXzMyX2JpdHMoZXZ0LT5kbWEpKTsNCj4gIAlkd2MzX3dy
aXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRBRFJISSgwKSwNCj4gIAkJCXVwcGVyXzMyX2JpdHMo
ZXZ0LT5kbWEpKTsNCj4gLQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRTSVooMCks
DQo+IC0JCQlEV0MzX0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5ndGgpKTsNCj4gKw0KPiArCS8qIFNr
aXAgZW5hYmxlIGR3YzMgZXZlbnQgaW50ZXJydXB0IGlmIGV2ZW50IGlzIHByb2Nlc3NpbmcgaW4g
bWlkZGxlICovDQo+ICsJaWYgKCEoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykpDQo+
ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVFNJWigwKSwNCj4gKwkJCQlEV0Mz
X0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5ndGgpKTsNCj4gKw0KPiAgCWR3YzNfd3JpdGVsKGR3Yy0+
cmVncywgRFdDM19HRVZOVENPVU5UKDApLCAwKTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAtLSAN
Cj4gMi4xNy4xDQo+IA0KDQpXZSdyZSBub3Qgd2FraW5nIHVwIGZyb20gYSBoaWJlcm5hdGlvbi4g
U28gYWZ0ZXIgYSBzb2Z0LXJlc2V0IGFuZA0KcmVzdW1lLCB0aGUgZXZlbnRzIHRoYXQgd2VyZW4n
dCBwcm9jZXNzZWQgYXJlIHN0YWxlLiBUaGV5IHNob3VsZCBiZQ0KcHJvY2Vzc2VkIHByaW9yIHRv
IGVudGVyaW5nIHN1c3BlbmQgb3IgYmUgZGlzY2FyZGVkIGJlZm9yZSByZXN1bWUuDQoNClRoZSBz
eW5jaHJvbml6ZV9pcnEoKSBkdXJpbmcgc3VzcGVuZCgpIHdhcyBub3Qgc3VmZmljaWVudCB0byBw
cmV2ZW50DQp0aGlzPyBXaGF0IGFyZSB3ZSBtaXNzaW5nIGhlcmUuDQoNClRoYW5rcywNClRoaW5o

