Return-Path: <linux-kernel+bounces-281646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC96C94D944
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06D21C21452
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7197E16D4FA;
	Fri,  9 Aug 2024 23:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K95Q+ITS";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aXIaaTJz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DXftaTMb"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105A12E7E;
	Fri,  9 Aug 2024 23:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247161; cv=fail; b=DWa8BGxxigjOhqakGFm6xOy3Q4iUhnjqogdoeERSu4kdpwLqXRi8sJCwGn0IL6wwQwIKZR7wXr8qzFrfbM22fMhyzspVVFOuXccDGVt+zElPAwn92HtjpSKS0wQcq2GjmnTfNAwnY81A9CbCXOISMpsJ03R5VYvOtdqkHWi9aos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247161; c=relaxed/simple;
	bh=XI2EyzwOYHOWUPH7YhrrT3oNdkz7Olawyz4p9BhidmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lxe4cp7M10usCZEczRvwcGn4CS62etQZAv9J+B8AEIU1/vYXJNp3VNCW1UG+hAelmmf+3fLVop/JwOUbfsRRQdMCqDGmM/Ylf00NsrWYZ3Bm9k1bZ5NJgK3cu2gFczswvXvPfDtvZP5pZH30K/lp/KLtUrJfJnX9VlhP/wrWDj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=K95Q+ITS; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aXIaaTJz; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DXftaTMb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479MBvPB031444;
	Fri, 9 Aug 2024 16:45:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=XI2EyzwOYHOWUPH7YhrrT3oNdkz7Olawyz4p9BhidmY=; b=
	K95Q+ITSHQ2Wu2D1wOcIgVZd2iJmvUIgi8D1O3qWMu5UTF8fDdpv3IkvJ5iZ+9uK
	7GcdHFie5QN/n8ommRUCkxP3jmHxRB8T68HfaRsEMsVsl53HEWKhpjDhAuWbLwIL
	V0+d7p75MdJPsbSbA7YFkifbU/EA0ZejK4LgQyq0lpEcI8YIDl74lPTXyuQjLz3c
	up4+r7XGevrP5euCUhoxX2Wg4EL11ePf0GSMSOkaMbfUeHZjMQvWmVK2PLPADv4P
	Po4p3C8JpNRPdxbICqC+yE1DL9C6L2u9qpMKr5z3Eo9q0orweISJaAVK3kwPQdHg
	e4uaeL+FMFdxcEZVZLt9aA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uuj6ash5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 16:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723247153; bh=XI2EyzwOYHOWUPH7YhrrT3oNdkz7Olawyz4p9BhidmY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=aXIaaTJz0cX4mfLtJ0XYGa715rMzD2zeQAzk4xtcwGr720X0CRrSDULjPtJRje3f1
	 J7l+4KfcIlXQw3GK5hQh1Payjs3wMsslS/AeS1yuILic14MbBgEtpwuTSxD7McRBUO
	 6QDJbGm9rQmQ1zLjMA9kEzshjrZryU3w5uCga9eNMcRGjnfvVCJThskO6pUdxo/aT2
	 t73sYvEOrUeNNmLo7ghXiA/pHF0YXWCWNb1Ooj3L5tb0NEGfKSUQdqMWcuvdIvqHl9
	 nfrdfFdj/rpvk1V/h6JFeJYDgyWzRUsqyeahAcN+LUlf97iB/bG1Z3S9yXbiEf14io
	 5KNPmt+iaOMaw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B585B40235;
	Fri,  9 Aug 2024 23:45:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5DCECA006B;
	Fri,  9 Aug 2024 23:45:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=DXftaTMb;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 348DD4044C;
	Fri,  9 Aug 2024 23:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeM3Uc41Vuz664fcaPgxUWvCYiH3MZJVmOvoZkZekEVlMfuoPuPUpQyaB/l+CkOvMXTGSLmrwMVqceFflQsReBQ5zgLsXmi+3YYkZLxhmpTLjAoeA4XTOum/CXWpJiVf4EW4dEtFyZenGeVezXGtBWZtWiaWh1bGnBElacG2hC4SUh6Ub8XnLwKq272KN/JQNhOhTovZ1tZ+eu/uGYoTqybwXZqi+UQK6KcrzU4zDN9w691olLPMPBVAwvXCBULp3jygQxZm7vNBnHvX1TvDI5u9YX92V+OMA3kQXIuTh6Gk6fRfb9Em8rkFfOXPj0matTzVHzt8JU/1Nkyd5VIcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI2EyzwOYHOWUPH7YhrrT3oNdkz7Olawyz4p9BhidmY=;
 b=ZSwyVFHI610x/q3w/JQwmon2bElVus3L1oFkXm0GOS8XWKgpLrFvWG+oxwRLw5kj8UA3ur3AF7lfFWxDvafj9cMK19X9Vz3SfvXn8d34PA22xPrvczhNoVZAgHmGJQzxBw064Nb9Gj4ihTMjTgCu8uMzMrhPkN3tP2Y9vtYuTxE/eXpORBDWOJWuYnTLZeBgON67wd9R2JZfyAzJLHN/d+kkaP3+btATAvt5l8DYOtK75geFxlTUkdrYMwCMbCy2hmio9eyioFXvR+F0GGGB6lWka/3P2aynQW76DSDD+45wY/2JJO+PbBaXWeFW2+x2BkzM430nLo3iCoBzWUkemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI2EyzwOYHOWUPH7YhrrT3oNdkz7Olawyz4p9BhidmY=;
 b=DXftaTMbaVxnbIpjPYsSvBNAE8dvCLQSqmrNOO8Uxl7yAZ5au17dW082KynT1tS1hppHw3kGsWVRDHt4CFu9zTmlmzWaWcLdjUqlDjuP5cHDtYapp0tGHYZI3565lPV/2+9AI1IKGdZ1OWz/nm3Yb6pf0tot0E5jbVR/JcrhYds=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Fri, 9 Aug
 2024 23:45:49 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 23:45:48 +0000
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
Thread-Index:
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAAADmAA==
Date: Fri, 9 Aug 2024 23:45:48 +0000
Message-ID: <20240809234540.wyanxgos7j4d7cu2@synopsys.com>
References:
 <CGME20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2@epcas5p3.samsung.com>
 <20240719110100.329-1-selvarasu.g@samsung.com>
 <20240807003806.5owtgwgw2lczg4u5@synopsys.com>
 <b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
 <20240808011536.oid627ez4ppdfkhp@synopsys.com>
 <b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
 <20240809234227.eriwy5e6leatzdyh@synopsys.com>
In-Reply-To: <20240809234227.eriwy5e6leatzdyh@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB6826:EE_
x-ms-office365-filtering-correlation-id: 9ae7cf44-5985-450c-283c-08dcb8cd655c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2Z1VEVBcVhsVXFyUkpiV1dRZ2hsWXlJcEI4QkcvTHhzWjZZdUp2WWEvSXpF?=
 =?utf-8?B?UDhwYVdLUVBadUtoRnhxN2RxZkNVVjIrY2JZdmtsVGN0VEczM1lSQmw0a1U1?=
 =?utf-8?B?MExjbEhuNUErUmpHODNYK2VMRk5taVl5UmpEV2JSdFd3aWVDSGpIQjNmeGRF?=
 =?utf-8?B?SnJPWDY5S0I4eDhkZ2ljNmVIVDJtSGRsNDNBUU4ydVdIUnEyaWJTSFJySGJX?=
 =?utf-8?B?UEpLenNQR0tkVVJnenpNOFJ3QWtFVVlwWmp2MytSK2hUMEdKeTNiQXJpaldS?=
 =?utf-8?B?UlM0cE1DclNKMkxMOXY5ZEowbG9pR3UvY3lPRlBIUSsxVG9nYWd6bzNKdnRY?=
 =?utf-8?B?Zll5TkRkclY0MG55ZllhMEZTcHBweDBXVXI5VElpZzgvSXBoODNaZS8vRmdY?=
 =?utf-8?B?dnlPcWh2UHh2TlhxZU1Cc0gzaEhHcjhoclJ4STVGdjBXS0M4SmJkQXNMeG9a?=
 =?utf-8?B?bllDZ29Gem5OSk8wbTgrSno2Y1Y2TmZLSFlZdnJneWlac0NKM2NQRkFibFM0?=
 =?utf-8?B?VXY1U014VHUwY01NMHpmdlYxZU5sUy85SnA5Vks3KzU5L1hXQUdoTnByczRu?=
 =?utf-8?B?NjJQcDI4WDdVeVlkMm94dysvaTFrZ20yUGkzb0lUdkQzSWh5MklYZm9LV1Vt?=
 =?utf-8?B?SHRpZGxxK1pkVDJPeW5JdUVCdTVWK3VEZXBBbDN2bnBxOC9XQlVwMm9CZmdZ?=
 =?utf-8?B?SC9GT0dvcW1YU0FrNFpVSVdTOHE1NVYvck9xSTc4eTBtMlZPUWxmbUgvNjg5?=
 =?utf-8?B?eUJsRDdDR2MraWJFWjBYcDIxeFhzS2djWWtZUjMvRzQvZTZDbWZMczVlUTN4?=
 =?utf-8?B?cjIzUlpoK1VUdHBrRUJvQUs5ajJIZzRIYXY1RlN4QVU5UmorMTNYZFB0aXRF?=
 =?utf-8?B?a0ZNbDVaMDBXbkZBN3d6TWpBSnZIQ2R3NkVHSS9CampYbGtVQ21udVpEanl3?=
 =?utf-8?B?Y3hET1RTNmxtNzU2QVhSZFhmaCthdnBUMFhjaVJKVzBJTDIzYVRwa1BOZ2xO?=
 =?utf-8?B?VG9rN0I3NVhIMmlTUUpES2hCZnBDbE9aMG1ZLzFySjg3RUc3VlcxR1RpaUlV?=
 =?utf-8?B?ajBGVERNYWZ6eUxNaGZQVVpzaVpTcjJ5OHZIb3YxSFJSdFdBTENHb2FId1Ex?=
 =?utf-8?B?TnpYVG53ODRoSXozbnNXQnFaSDkzTVkwSE1URlpyNjR5RysyRmFLdmpGclBz?=
 =?utf-8?B?TjM0c3BqcnRBOS9PSUdJbk1XN0QrZjkxT3BsejV1WEVCVDdxRzhiRjdveEZ6?=
 =?utf-8?B?MUJ3aVJ2NmxIb2M5Njhpa3JCK3hWYXMwdUdEbDhQdFVDVGYzYWZLN2Y5bmJ0?=
 =?utf-8?B?cjQ2OUFiY3ZZQ242WmpJYmRxc01OL1pGc0NEODRYZ05oNFExbVRaL2cxR1Zt?=
 =?utf-8?B?Rllhd2hXMDNtUTB6Sm9vYytNT0FXM2E0OFg3dUd3UGNHNEJWUWJ2WU84Skxq?=
 =?utf-8?B?Z0QxTmkrTVdVdFRaTk1qZFVLWk11WkhRUkkzb1hLb2EyUCtnMlFzM29FSFhx?=
 =?utf-8?B?Q28zWXowNjhETW1MZVVSc0hnb2JZY2ErMEk3b214eDNiQU5SMCtYdFVnTXox?=
 =?utf-8?B?SnA1b3lYMlV3dEI1N1F2Y3NRTVNOcVJrS2xSdzdpbS9WY2NER21mRUt2S2Y4?=
 =?utf-8?B?MFlubFA1RktnMWtZN0pDQ0M0TXNxQXlHWERNaThwdmVIMXJmNGtsUkNwUDlJ?=
 =?utf-8?B?T25pdG9MbVRHcnVEQU15bmJmdGpyM3Nlc2hNemIveEtQbEljMEwweDZCNnd3?=
 =?utf-8?B?ZDF1d2luVlNFMU5JWDZwbDdGMTd6YlA5dk50S00wdEN6L2Zob1NVVVRGNE9C?=
 =?utf-8?B?ZEdWWjI1eENCbzNZajBUZWhBTTVpeCtjQXNaWC9JTkp4YVRrVXl1QU1YbnFr?=
 =?utf-8?B?QjY3REpVc3RmY1V6Z09seFVUaUdXWkVTbXZhcExKbm55c0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDRidFllUFd5TWIzYjNiajVlSlI4aTEwbVFhZUpRYXlEbXlnSnp3RTdLenJ1?=
 =?utf-8?B?UkFmSldIOHpKbUVOZFZkQTZKN09taWZMOUxlM0RsWEM4Zzg2VFkxRU4wUjdt?=
 =?utf-8?B?Rk1Bc3E1R2hMd05kUEphbHcyTHhPS2tOMlQ5WThxWi9HOXN0cWFPUFZRU1B5?=
 =?utf-8?B?Y1pobDBLMUpFeDZ5NmRqR3BTY0RwZzFtcnVIYVNIdm5Idm5qaERNcFZOazlD?=
 =?utf-8?B?Nm9BMnhIUTZFMjUySTVCUzk2R2E4MTBCdWdyUGc1M2htYko0aWlNSzNhc1R2?=
 =?utf-8?B?UWdyS0I2WlRLOVFKUnlFaTcvb2lmYTdoUE9QYk14ZnpvOFgrdCtpZWM0RCtT?=
 =?utf-8?B?ZTRXRUNxbkExWFV6aGJ6MW5TRk4wVytha3M1TzQzTHB4NFJQNGhlanlyVCtk?=
 =?utf-8?B?VWpVbDR5YktJMlcySzdrMjQ5THVSN0E3a0w4ZXVIM3ZkV29JOTVUelJyczZB?=
 =?utf-8?B?WFp1VGdvQWFPcGxVV3VMMUpxbExLVWVIZ1J0VWVCWDNlcHJaL0UrR1Fycnc5?=
 =?utf-8?B?ME96Q1RSd2FZS3p3TWZzZjREcHFFQ2pwSXF4QkFrZVRlTmprRWJWZ1NldEUx?=
 =?utf-8?B?ZXBiR1hKY1picnV0emUvRVhZOVJHS2dJV1JtK2NGOGwyaElPOU5nUXczT1Jr?=
 =?utf-8?B?Y05rMEhPUHNOT0hKWVYwQkVucXNaN25yNyt4U2JLQVBiZGFoQlEzZVZycUlV?=
 =?utf-8?B?ZU1NZGpKbVRTSHNIUGlQbW0wOS93V0xuVEtPVzVJVU1WTnJPeHpIUXkwcmpE?=
 =?utf-8?B?RUd3NEF2VzEzajU3OTNaOW9kM3NCZkxNNGlQN3UvcXk3dEE4aTRLQVVPdjFv?=
 =?utf-8?B?dm5FaEFYcVQ3SlBMcnE5WjVNajJoTWMzbGMrNUhBVGNlZzM2SnBJTGlXZnRn?=
 =?utf-8?B?R3RoZkk0TEtjQlI3eTRQVEJGTDRqaTJhTUFubE4yeDcyTVVOeVBKUElsdUda?=
 =?utf-8?B?ZndrM2E3V0UzUDNwUjRnNFdaM3FBZTdFTDg0ZDl4ejk5MDFHdVBjZkQwdWYr?=
 =?utf-8?B?YlY5MkJXemMzQ09BZGJ3aEtKR1FsT0hjVzZtL0ViRTIzdy96QXNnVXl6OXJ3?=
 =?utf-8?B?VUc2TFM3TlkrSjNoMnVEQTB4eWYzK0x5T3dqcU1wNFFOMFo0dzQ5MmY3K0pv?=
 =?utf-8?B?SmphS3BiOG1sMG9peDNQOUgrbEhtSmFWVlJwUXZ2WnhrQytlR1NMZC81MWZn?=
 =?utf-8?B?cE9LNG9MenhBN042ZTlSUlJtbXhqM1lYWTNicS9WRDRlK0lxZkxEdHh6aldL?=
 =?utf-8?B?VkR2bDJHRFRoeGlLS3FDK3AvUXYvTGN2Tkc4WHluWFpNaWsyL2lyNnlQS3Fz?=
 =?utf-8?B?eDN2NmtEMVN5OEkwRStoY1J5TjMzclJRWCsrYnhwRk92WlNqdEZwWXFKMWpN?=
 =?utf-8?B?RE9VMWJ3bUFGakd0enN3RWFqNjVMRGszeENNWEcvVnExWEwyQmw1R3hkajhU?=
 =?utf-8?B?T2R5bEdTQWpPNlFmamhaamxGaFZ3TkxieTFVdXd2bWRVcEY3UjdaZlBlZG0r?=
 =?utf-8?B?MzBrbkpKNElpdkJVUE9YSERWN3QxeWQzcE85elZtOXFvaU01S2gyTGtWVmkr?=
 =?utf-8?B?VVZMLzBXUHZMSzRaNk8xNzdmNG95aUxqUEp1UFYrZVBTZUxrMzE5UVREbk5a?=
 =?utf-8?B?S05TSkt2Yms2TTNrQ1BvS0Q5cEFkelY4NTduSUNwTUh1R3kzUk1qdDc3MFBi?=
 =?utf-8?B?T2kxQWdadjVsU3YwaFZCT1UyampKMTFncU1zNzF2bFpvSVRmUExqenk5Nncr?=
 =?utf-8?B?UnlWdXlwckF5dDNJaEtNbFN3ay83UmFSYURGekNQTEtJYlhqOVQvSWlteFV5?=
 =?utf-8?B?dTkrK0wzU0h5dFB1RFFpRlFmenBpTXNLeVowMitteDQyYmwzMWorSjRtak5Z?=
 =?utf-8?B?d3JoSGZmNHhpSXpqWUY2Y0xZam1sdG9ydFRRdndYeElaa1BKRStCWHBoY2hQ?=
 =?utf-8?B?Z3VWSFVSVjhtWGdQSzNhbEk0NGR2SWN0d0pWcDlqbktTUVhzSnpKQ0RIajdN?=
 =?utf-8?B?dGVIVW1FK3A3RlViUWZyRk93aHMvbDRUbGMycTZKNUNHeElFRmptQmVpNlhu?=
 =?utf-8?B?MU93TUw0eXBjeHhCVmQrMlczZnppdXFrRW5EQlRKZTVaSEVXZDNlcFNWSE9o?=
 =?utf-8?B?UUJFWnFpSE0va1RTai9PWEVRMVZONnpVYXNBU3NyTG1TZUprdkZtR1FiWDRs?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F803BA1FA51941B6642700AB1F5385@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xzg5fbtLYgIIBeMFSeSNDOLxXiDgbC1Cc24DJrBtAWAbdgM8YF7EPMJY1sELMkbeF2wWclCEKSeN+Qt2LjR82HnlssG0KGmHnicHdIhdt9fKji2RwhmSkOcOMzFHMrwgxWNT9HKSA9AYMR/IYUWdu+WHKAbgB0C2lzARKLMU5lU/o1tf/bGM6gKQZzBx0PcT3qR0n1aNwPirBHIzFCcTZNhtDBTQT5MQ37CjRsFj7xijlynw3Pc683Lg3x8Luzer9GOMkVLst+LvEHgGkhW+X9AypQxBO6+X8JEZg4fWvwCjvBNLm307ZyeAZJBXDe9ZAm6a8kaJzLieQth/gevPkNmR0KJysvxAERYCEjPhjMVsFgoV5qHqxEew36qv5ShpP/P0oqJ+cFsmdm+A5vltnkT1nS6ZEmcjjumtkxMZxxZkSmOtRtsruCVXOzb0rmEcfXBQ+J0mYgsJW52vrIESTPfal0nUKcLwk682+/ZTYiUymxyYH1fPx01B4BcOTcU6/TpulpmPK1LN41HchvghjqOL1AqoU9ZQVPnPoXPTHIqVomnC43zUhxlJ8T6vSOarUJyCohSGSe2BQ+6LlpbSZ85aslMCSqzshYZkVgAMOl3d1PkgUoRDtkEjhcLfwRNuI8APVh5kuI/WvPgNjPSpsA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae7cf44-5985-450c-283c-08dcb8cd655c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 23:45:48.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcfvXcfWUqwitF8XUeRhW/xbbGrmKKrSwZhvRBhxS+TamQBpVQcWdPLL9gS18Dk8P4IqJPIaewn/jQzAfd8wwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
X-Proofpoint-ORIG-GUID: 4Yfn1wocEmKsiqm0VH0PrXgY4rarKN6e
X-Proofpoint-GUID: 4Yfn1wocEmKsiqm0VH0PrXgY4rarKN6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090172

T24gRnJpLCBBdWcgMDksIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gVGh1LCBBdWcg
MDgsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+IA0KPiA+IE9uIDgvOC8yMDI0
IDY6NDUgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgQXVnIDA3LCAyMDI0
LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPiA+PiBPbiA4LzcvMjAyNCA2OjA4IEFNLCBU
aGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPj4+IE9uIEZyaSwgSnVsIDE5LCAyMDI0LCBTZWx2YXJh
c3UgR2FuZXNhbiB3cm90ZToNCj4gPiA+Pj4+IEluIGNlcnRhaW4gc2NlbmFyaW9zLCB0aGVyZSBp
cyBhIGNoYW5jZSB0aGF0IHRoZSBDUFUgbWF5IG5vdCBiZQ0KPiA+ID4+Pj4gc2NoZWR1bGVkIHRo
ZSBib3R0b20gaGFsZiBvZiBkd2MzIGludGVycnVwdC4gVGhpcyBpcyBiZWNhdXNlIHRoZSBDUFUN
Cj4gPiA+Pj4+IG1heSBoYW5nIHVwIHdoZXJlIGFueSB3b3JrIHF1ZXVlIGxvY2t1cCBoYXMgaGFw
cGVuZWQgZm9yIHRoZSBzYW1lIENQVQ0KPiA+ID4+Pj4gdGhhdCBpcyB0cnlpbmcgdG8gc2NoZWR1
bGUgdGhlIGR3YzMgdGhyZWFkIGludGVycnVwdC4gSW4gdGhpcyBzY2VuYXJpbywNCj4gPiA+Pj4+
IHRoZSBVU0IgY2FuIGVudGVyIHJ1bnRpbWUgc3VzcGVuZCBhcyB0aGUgYnVzIG1heSBpZGxlIGZv
ciBhIGxvbmdlciB0aW1lDQo+ID4gPj4+PiAsIG9yIHVzZXIgY2FuIHJlY29ubmVjdCB0aGUgVVNC
IGNhYmxlLiBUaGVuLCB0aGUgZHdjMyBldmVudCBpbnRlcnJ1cHQNCj4gPiA+Pj4+IGNhbiBiZSBl
bmFibGVkIHdoZW4gcnVudGltZSByZXN1bWUgaXMgaGFwcGVuaW5nIHdpdGggcmVnYXJkbGVzcyBv
ZiB0aGUNCj4gPiA+Pj4+IHByZXZpb3VzIGV2ZW50IHN0YXR1cy4gVGhpcyBjYW4gbGVhZCB0byBh
IGR3YzMgSVJRIHN0b3JtIGR1ZSB0byB0aGUNCj4gPiA+Pj4+IHJldHVybiBmcm9tIHRoZSBpbnRl
cnJ1cHQgaGFuZGxlciBieSBjaGVja2luZyBvbmx5IHRoZSBldnQtPmZsYWdzIGFzDQo+ID4gPj4+
PiBEV0MzX0VWRU5UX1BFTkRJTkcsIHdoZXJlIHRoZSBzYW1lIGZsYWcgd2FzIHNldCBhcyBEV0Mz
X0VWRU5UX1BFTkRJTkcNCj4gPiA+Pj4+IGluIHByZXZpb3VzIHdvcmsgcXVldWUgbG9ja3VwLg0K
PiA+ID4+Pj4gTGV0J3MgY29uc2lkZXIgdGhlIGZvbGxvd2luZyBzZXF1ZW5jZXMgaW4gdGhpcyBz
Y2VuYXJpbywNCj4gPiA+Pj4+DQo+ID4gPj4+PiBDYWxsIHRyYWNlIG9mIGR3YzMgSVJRIGFmdGVy
IHdvcmtxdWV1ZSBsb2NrdXAgc2NlbmFyaW8NCj4gPiA+Pj4+ID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ID4+Pj4gSVJRICMxOg0KPiA+
ID4+Pj4gLT5kd2MzX2ludGVycnVwdCgpDQo+ID4gPj4+PiAgICAgLT5kd2MzX2NoZWNrX2V2ZW50
X2J1ZigpDQo+ID4gPj4+PiAgICAgICAgICAgLT5pZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRf
UEVORElORykNCj4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIElSUV9IQU5E
TEVEOw0KPiA+ID4+Pj4gICAgICAgICAgIC0+ZXZ0LT5mbGFncyB8PSBEV0MzX0VWRU5UX1BFTkRJ
Tkc7DQo+ID4gPj4+PiAgICAgICAgICAgLT4vKiBEaXNhYmxlIGludGVycnVwdCBieSBzZXR0aW5n
IERXQzNfR0VWTlRTSVpfSU5UTUFTSyAgaW4NCj4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEV0MzX0dFVk5UU0laDQo+ID4g
Pj4+PiAgICAgICAgICAgLT5yZXR1cm4gSVJRX1dBS0VfVEhSRUFEOyAvLyBObyB3b3JrcXVldWUg
c2NoZWR1bGVkIGZvciBkd2MzDQo+ID4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB0aHJlYWRfZnUgZHVlIHRvIHdvcmtxdWV1ZSBsb2NrdXANCj4gPiA+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV2ZW4gYWZ0ZXIgcmV0dXJuIElS
UV9XQUtFX1RIUkVBRA0KPiA+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZnJvbSB0b3AtaGFsZi4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBUaHJlYWQgIzI6DQo+ID4g
Pj4+PiAtPmR3YzNfcnVudGltZV9yZXN1bWUoKQ0KPiA+ID4+Pj4gICAgLT5kd2MzX3Jlc3VtZV9j
b21tb24oKQ0KPiA+ID4+Pj4gICAgICAtPmR3YzNfZ2FkZ2V0X3Jlc3VtZSgpDQo+ID4gPj4+PiAg
ICAgICAgIC0+ZHdjM19nYWRnZXRfc29mdF9jb25uZWN0KCkNCj4gPiA+Pj4+ICAgICAgICAgICAt
PmR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cCgpDQo+ID4gPj4+PiAgICAgICAgICAgICAgLT4vKkVu
YWJsZSBpbnRlcnJ1cHQgYnkgY2xlYXJpbmcgIERXQzNfR0VWTlRTSVpfSU5UTUFTSyBpbg0KPiA+
ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIERXQzNfR0VWTlRTSVoqLw0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFN0YXJ0IElSUSBTdG9y
bWluZyBhZnRlciBlbmFibGUgZHdjMyBldmVudCBpbiByZXN1bWUgcGF0aA0KPiA+ID4+Pj4gPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+
ID4gPj4+PiBDUFUwOiBJUlENCj4gPiA+Pj4+IGR3YzNfaW50ZXJydXB0KCkNCj4gPiA+Pj4+ICAg
IGR3YzNfY2hlY2tfZXZlbnRfYnVmKCkNCj4gPiA+Pj4+ICAgICAgICAgICBpZiAoZXZ0LT5mbGFn
cyAmIERXQzNfRVZFTlRfUEVORElORykNCj4gPiA+Pj4+ICAgICAgICAgICAgcmV0dXJuIElSUV9I
QU5ETEVEOw0KPiA+ID4+Pj4NCj4gPiA+Pj4+IENQVTA6IElSUQ0KPiA+ID4+Pj4gZHdjM19pbnRl
cnJ1cHQoKQ0KPiA+ID4+Pj4gICAgZHdjM19jaGVja19ldmVudF9idWYoKQ0KPiA+ID4+Pj4gICAg
ICAgICAgIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0KPiA+ID4+Pj4gICAg
ICAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4gPj4+PiAuLg0KPiA+ID4+Pj4gLi4NCj4g
PiA+Pj4+DQo+ID4gPj4+PiBUbyBmaXggdGhpcyBpc3N1ZSBieSBhdm9pZGluZyBlbmFibGluZyBv
ZiB0aGUgZHdjMyBldmVudCBpbnRlcnJ1cHQgaW4NCj4gPiA+Pj4+IHRoZSBydW50aW1lIHJlc3Vt
ZSBwYXRoIGlmIGR3YzMgZXZlbnQgcHJvY2Vzc2luZyBpcyBpbiBwcm9ncmVzcy4NCj4gPiA+Pj4+
DQo+ID4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdA
c2Ftc3VuZy5jb20+DQo+ID4gPj4+PiAtLS0NCj4gPiA+Pj4+ICAgIGRyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jIHwgOCArKysrKystLQ0KPiA+ID4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+Pj4+DQo+ID4gPj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4+
Pj4gaW5kZXggY2I4MjU1NzY3OGRkLi42MTA3OTJhNzA4MDUgMTAwNjQ0DQo+ID4gPj4+PiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4+Pj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gPiA+Pj4+IEBAIC01NDksOCArNTQ5LDEyIEBAIGludCBkd2MzX2V2ZW50X2J1
ZmZlcnNfc2V0dXAoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+Pj4+ICAgIAkJCWxvd2VyXzMyX2Jp
dHMoZXZ0LT5kbWEpKTsNCj4gPiA+Pj4+ICAgIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNf
R0VWTlRBRFJISSgwKSwNCj4gPiA+Pj4+ICAgIAkJCXVwcGVyXzMyX2JpdHMoZXZ0LT5kbWEpKTsN
Cj4gPiA+Pj4+IC0JZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UU0laKDApLA0KPiA+
ID4+Pj4gLQkJCURXQzNfR0VWTlRTSVpfU0laRShldnQtPmxlbmd0aCkpOw0KPiA+ID4+Pj4gKw0K
PiA+ID4+Pj4gKwkvKiBTa2lwIGVuYWJsZSBkd2MzIGV2ZW50IGludGVycnVwdCBpZiBldmVudCBp
cyBwcm9jZXNzaW5nIGluIG1pZGRsZSAqLw0KPiA+ID4+Pj4gKwlpZiAoIShldnQtPmZsYWdzICYg
RFdDM19FVkVOVF9QRU5ESU5HKSkNCj4gPiA+Pj4+ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywg
RFdDM19HRVZOVFNJWigwKSwNCj4gPiA+Pj4+ICsJCQkJRFdDM19HRVZOVFNJWl9TSVpFKGV2dC0+
bGVuZ3RoKSk7DQo+ID4gPj4+PiArDQo+ID4gPj4+PiAgICAJZHdjM193cml0ZWwoZHdjLT5yZWdz
LCBEV0MzX0dFVk5UQ09VTlQoMCksIDApOw0KPiA+ID4+Pj4gICAgDQo+ID4gPj4+PiAgICAJcmV0
dXJuIDA7DQo+ID4gPj4+PiAtLSANCj4gPiA+Pj4+IDIuMTcuMQ0KPiA+ID4+Pj4NCj4gPiA+Pj4g
V2UncmUgbm90IHdha2luZyB1cCBmcm9tIGEgaGliZXJuYXRpb24uIFNvIGFmdGVyIGEgc29mdC1y
ZXNldCBhbmQNCj4gPiA+Pj4gcmVzdW1lLCB0aGUgZXZlbnRzIHRoYXQgd2VyZW4ndCBwcm9jZXNz
ZWQgYXJlIHN0YWxlLiBUaGV5IHNob3VsZCBiZQ0KPiA+ID4+PiBwcm9jZXNzZWQgcHJpb3IgdG8g
ZW50ZXJpbmcgc3VzcGVuZCBvciBiZSBkaXNjYXJkZWQgYmVmb3JlIHJlc3VtZS4NCj4gPiA+Pj4N
Cj4gPiA+Pj4gVGhlIHN5bmNocm9uaXplX2lycSgpIGR1cmluZyBzdXNwZW5kKCkgd2FzIG5vdCBz
dWZmaWNpZW50IHRvIHByZXZlbnQNCj4gPiA+Pj4gdGhpcz8gV2hhdCBhcmUgd2UgbWlzc2luZyBo
ZXJlLg0KPiA+ID4+Pg0KPiA+ID4+PiBUaGFua3MsDQo+ID4gPj4+IFRoaW5oDQo+ID4gPj4gSSBk
b27igJl0IHRoaW5rIHRoZSB0cmlnZ2VyaW5nIG9mIGludGVycnVwdCB3b3VsZCBub3QgYmUgc3Rv
cHBlZCBldmVuIGlmDQo+ID4gPj4gZG8gc29mdCByZXNldC4gSXQncyBiZWNhdXNlIG9mIGV2ZW50
IGNvdW50IGlzIG1heSBiZSB2YWxpZCAuDQo+ID4gPiBPay4gSSB0aGluayBJIHNlZSB3aGF0IHlv
dSdyZSByZWZlcnJpbmcgdG8gd2hlbiB5b3Ugc2F5ICJldmVudCBpcw0KPiA+ID4gcHJvY2Vzc2lu
ZyBpbiB0aGUgbWlkZGxlIiBub3cuDQo+ID4gPg0KPiA+ID4gV2hhdCB5b3Ugd2FudCB0byBjaGVj
ayBpcyBwcm9iYWJseSB0aGlzIGluIGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cCgpLg0KPiA+ID4g
UGxlYXNlIGNvbmZpcm06DQo+ID4gPg0KPiA+ID4gaWYgKGR3Yy0+cGVuZGluZ19ldmVudHMpDQo+
ID4gPiAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UU0laKDApLA0KPiA+ID4gCQkJ
RFdDM19HRVZOVFNJWl9JTlRNQVNLIHwgRFdDM19HRVZOVFNJWl9TSVpFKGV2dC0+bGVuZ3RoKSk7
DQo+ID4gPiBlbHNlDQo+ID4gPiAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UU0la
KDApLCBEV0MzX0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5ndGgpKTsNCj4gPiANCj4gPiBZZXMsIHdl
IGFyZSBleHBlY3RpbmcgdGhlIHNhbWUuIEJ1dCwgd2UgbXVzdCB2ZXJpZnkgdGhlIHN0YXR1cyBv
ZiANCj4gPiBldnQtPmZsYWdzLCB3aGljaCB3aWxsIGluZGljYXRlIHdoZXRoZXIgdGhlIGV2ZW50
IGlzIGN1cnJlbnRseSANCj4gPiBwcm9jZXNzaW5nIGluIG1pZGRsZSBvciBub3QuIFRoZSBiZWxv
dyBjb2RlIGlzIGZvciB0aGUgcmVmZXJlbmNlLg0KPiA+IA0KPiA+IGlmICghKGV2dC0+ZmxhZ3Mg
JiBEV0MzX0VWRU5UX1BFTkRJTkcpKQ0KPiA+IAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNf
R0VWTlRTSVooMCksDQo+ID4gCQkJIERXQzNfR0VWTlRTSVpfU0laRShldnQtPmxlbmd0aCkpOw0K
PiA+IGVsc2UNCj4gPiAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UU0laKDApLA0K
PiA+IAkJCURXQzNfR0VWTlRTSVpfSU5UTUFTSyB8IERXQzNfR0VWTlRTSVpfU0laRShldnQtPmxl
bmd0aCkpOw0KPiANCj4gU28sIHRoaXMgaGFwcGVucyB3aGlsZSBwZW5kaW5nX2V2ZW50cyBpcyBz
ZXQgcmlnaHQ/IEkgbmVlZCB0byByZXZpZXcNCj4gdGhpcyBydW50aW1lIHN1c3BlbmQgZmxvdyBu
ZXh0IHdlZWsuIFNvbWV0aGluZyBkb2Vzbid0IGxvb2sgcmlnaHQuIFdoZW4NCj4gdGhlcmUncyBh
IHN1c3BlbmQvcmVzdW1lIHJ1bnRpbWUgb3Igbm90LCB0aGVyZSdzIGEgc29mdCBkaXNjb25uZWN0
LiBXZQ0KPiBzaG91bGRuJ3QgYmUgcHJvY2Vzc2luZyBhbnkgZXZlbnQgcHJpb3IgdG8gZ29pbmcg
aW50byBzdXNwZW5kLiBBbHNvLCB3ZQ0KDQpDbGFyaWZpY2F0aW9uOiBJIG1lYW4gd2Ugc2hvdWxk
bid0IHByb2Nlc3MgYW55IGV2ZW50IHRoYXQgaGFwcGVuZWQgcHJpb3INCnRvIHN1c3BlbmQgb24g
cmVzdW1lIGJlY2F1c2UgdGhlcmUgd2FzIGEgZGlzY29ubmVjdC4NCg0KPiBzaG91bGRuJ3QgYmUg
ZG9pbmcgc29mdC1kaXNjb25uZWN0IHdoaWxlIGNvbm5lY3RlZCBhbmQgaW4gb3BlcmF0aW9uDQo+
IHVubGVzcyB3ZSBzcGVjaWZpY2FsbHkgdGVsbCBpdCB0by4NCg0KVGhpbmg=

