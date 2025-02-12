Return-Path: <linux-kernel+bounces-510314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6764A31B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4342C3A91FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA51CAA4;
	Wed, 12 Feb 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GTzvvyOj";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RQoDvGKe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mrFwkN9Z"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CF1C13B;
	Wed, 12 Feb 2025 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739322643; cv=fail; b=JXdgnjuL+ELtgNVFxce2nC3ADzDnfoVcyopZU8IlZ0wbGvj5CfkqhmiNX/oIFGcjBPlp0NLpC0t3zBkhA0LUhveXtjDg3vxpRgZGDriwZKiE9zAJMMZGm/NRgIihldoF31vmzb+z7guxqXbkVXT3t47OgW3n1lA1E+xp8OZ3sXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739322643; c=relaxed/simple;
	bh=3TNYqsoU+YnzJaCsHX/Mb3zMbLvWjcA8LTN3ISzmx8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmWGd8FNOrJmSd5L6d4cZLo+/SQg6s1mLA0h95wHqpVvqKov5OeC+MxHcj2bCTG/+7jc1r+njTYShyFukn5TERahWRmb35ArrZZAItqC0x6lZHLT1K2HvdxFRUXqPfoCM5/kihRh0qkBXzieF0up++Bw3LAFoauDRnc8yqTV7Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GTzvvyOj; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RQoDvGKe; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mrFwkN9Z reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BIFRXK012930;
	Tue, 11 Feb 2025 17:10:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=3TNYqsoU+YnzJaCsHX/Mb3zMbLvWjcA8LTN3ISzmx8Y=; b=
	GTzvvyOj17l14PsG2K3rifIw3DBBcjCJ2U+X73CO/mFpzgTZiG7BMCAbVpsdaNIj
	yC202KjKsmLtLc2KSgEyBD0Tn51fTZPlxnzrPeQpSBvCDJf2LHq4WTTKT9hl6Teq
	jGwm9206GJf+wGUNwetTdp+x4+KpsXCK1Qb/wivcWq6F4XWkhfJWhJ3I1/mVe0Sd
	4VQ16+V6s9/Ymmd5Vcnb+8Y6hc2R8jBVt4+goaJsbfNlKBHSxzs+Vw41beNfKzcJ
	gyZJBymWN+s8jFW/nJUJPMnCLXriRRwwKg8XjekUY6NV8Tar1cztqBaaPDlumuHI
	itFyP0bpdV1ZJPNKXdfk8Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44qhduadts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 17:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739322623; bh=3TNYqsoU+YnzJaCsHX/Mb3zMbLvWjcA8LTN3ISzmx8Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RQoDvGKe3Wm8QSsuiLiQOtJ81ZWmDKE41BEJqMid3tYR/TyK7pHreCeAgIwxRS2CK
	 1Zf9ejHhaAZSj+eOLIDlxTbU0k1t+cxWnOtgsSXXLVw25jQY8qooTZcZqo2aRj5+X3
	 hjzrXJnLwU4478P3qHCTq3NQIVmAEdqz6C7gxrbllLcVXdWK7YQCXhX47aoPeVOOXj
	 XS4rUW8Kn1cn+cxf/eVhr4hLMPAz7ps4320RDoT2R/r4F6qtXHKCufTNbPDa90c/Il
	 7TMu9crQsuPdSh7Mz6TQ2zx079RJqAQB2mlphIscC1MmBFoLchPYe9bUvrpMAcEl9U
	 w8ZEu0rm97RaQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4B6BF40353;
	Wed, 12 Feb 2025 01:10:22 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B5C04A0067;
	Wed, 12 Feb 2025 01:10:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mrFwkN9Z;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9307E40518;
	Wed, 12 Feb 2025 01:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVS0KoAYfanZxjqruz4memAc/hFcHJ19tQF5KUoxTFhaFBt5wS+PjqUl7B7/kzou55EiEaQFuFMQ88PmQVe6wvdSPmPCvturfWMLpZwpe/wH47AMjtBxbrO3Z8ONriE7mCY9bNOprOBXkVj+0UXpwaGWE3W6a63nKXaEfmsgzw8s6Q03XBiXTbsCZolMVDYZ2JN3NitTiQPDlr27ZN9GWh5MonNVxpWNn6nTqX3mgVzXAGhJ4UqSan1YcjZq5CXv61Y3SZVBoRNRDiy0cloFr2s4vAN27Fv58CWu7prYNU2Uvx+VPPeL1+mbqyZptqHH6MltFRM5S4fdUHEh1aJFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TNYqsoU+YnzJaCsHX/Mb3zMbLvWjcA8LTN3ISzmx8Y=;
 b=tTG7zNXm9iQbt1EXIdKXzIjI0mxDXTdA+LzHm1aNl1YBPvHBI5pFy4CBl4gVYIXRxb2TYEipN0J1D9TFE0KFC2G2z71zfikdh8eN84XLhfFAUvp4ECVQR1ZyLDt2qRdOZrveq9PjZ3pSgz2SN91u9CIPPcTrztRQUD+2zp+eukx8PSop/cmnHYPMWZxNhp33cVqsWRhmXP9Cm6SqQQFXkzckJ7Vsm0+bqxB4jKskpihx3cyRvq6JZQuW5OJZ/03Y0FHEdkdjwnrlQ7YrnTyLfAVOzQMprEwf195VOggw4qAZttA2G4TyD0mVkJVnXCAhvuo91VfI4xvVCz1i6iEYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TNYqsoU+YnzJaCsHX/Mb3zMbLvWjcA8LTN3ISzmx8Y=;
 b=mrFwkN9ZbiCOuXf1FCmA9at+2YmIDE55Bhz4JvwL0GIXmqe5aJqeURBg55HXZnMR6CSu+/3fp1f7MmYR3YFxHQ5RrSjtyaka2b7d7Djo18s2/gCqBEVvrUJJQbiF/weD2EHXIAC5WY9iXIisvcw1NXXuIAtGKMT2Zcb+xag1h8o=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 01:10:17 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 01:10:17 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Topic: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Index: AQHbdnAAit2sY24YUU+11LLZH+RUWrNC6NyA
Date: Wed, 12 Feb 2025 01:10:17 +0000
Message-ID: <20250212011013.xumqgguhluxdslpz@synopsys.com>
References: <20250203191524.3730346-1-andriy.shevchenko@linux.intel.com>
 <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4240:EE_
x-ms-office365-filtering-correlation-id: 1d9f0b81-6135-4d90-168e-08dd4b02033b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzlUdkJ6QVczWWxYTlRJbkQ4aWFqV0hiRmRZRC9wQ1h2aktoeTlJSVNkOU5D?=
 =?utf-8?B?ZUZYdnd1QTdSbCtUQ3FId0ZpeTgwcVRYU2NDWGFaUDVrRHFHcnYrSDkxWU1Z?=
 =?utf-8?B?SUExQkJ2OVFBUURoN3dZRlh1UCtBYjhxRW5LSnh6UG1lODdQekd2L1o1bVk1?=
 =?utf-8?B?REdTTHozMnRVUXRQd2xqR2pqb2ZiNGs4V2s4eFRRS0dFRC9LM2hMczZpaDNB?=
 =?utf-8?B?bmR2MUI4TDBOaDNlOWRkMkJWMGxCTUVKR1hsNjhYdHkxbUc2VnM2cWxoOU1H?=
 =?utf-8?B?dU9sNkw0N3B1WUFZZmU5U2ozNVpITURmZENqRktNT3VTdHlJQ2pUTVVUWGdu?=
 =?utf-8?B?Z3RLZ0JNcTZmSGplZExUVm1nTHpGL3ZiZFQzaWszcGpxbEYydmlBWldQRFVC?=
 =?utf-8?B?UVdRamNyZUlYbHZLL1BFRkNZRjdoRmRnQVJxWEphSGh5WVFoaDNRRUwwSGZo?=
 =?utf-8?B?TjJqU1daZkpUbStaSmViRHVrb1A3VmtQY3V1QkpHWGExY2FmcmltUEVTbzFt?=
 =?utf-8?B?YTJLM01CR2N5aG14YWZ6djZkQ2xSbnhBVFpiQkd1VnluVGpUZStLaHBUOW43?=
 =?utf-8?B?S2JXVDAyK2VBajR6Z0x1dmoyekwxdXNHV0poYmZMSEwwd0RSWUJlODdieUxC?=
 =?utf-8?B?eTBkeG1sZ1Y1WEk2ang0cVNSLzlhb0xIQmFkbDI4Um9HQWR1RDR1UmFobENS?=
 =?utf-8?B?ZlJiUEZpaHFmcUpxN3dFbkVlWks3dnhNd0c1NGhCVGFwSi9qM3Q2ZDRMdjdl?=
 =?utf-8?B?dzFjUUpoTzNkNDZ1d0pBOE9jUkdCUEpza2tmYzRHdm9WTzlHQTJLZzQrMFhQ?=
 =?utf-8?B?Rlo4YTUya1E5aVNJTFZvZ1VjOE9Cd2V6Y09sem9UN0c1ZkZKZlpDUk5IcUc5?=
 =?utf-8?B?YzhkbEozNjJteUM5Unh1UzNHcVZGeXNHM0VaTkJLTUxYQXNXb2drM24remdB?=
 =?utf-8?B?dXFRS1ZKcTZObk1GcmdYSkZJa0tMZzh3REE0ak5mWVBsamNXSi9oUFNTUjR0?=
 =?utf-8?B?ZUd5WHRyeDA4QUhlNjBNSHB0cTROQ3JqQkxOeTZVbXRwWjFjMldRbmFNYnAx?=
 =?utf-8?B?ZjUwZTM2ZVpQQkNqbnNhWWRReEdwTkZrNmhmNnJKRXZUaUNvQ1FxYjErYmx1?=
 =?utf-8?B?QTZBbnpDY0tXMUtiSlJTYitXdXhkTXZ6SVFIV3NyL3lmNlYyc1BrcWhZV0lv?=
 =?utf-8?B?WjViRlM4dDBONUI4em5ZUWxhVWtIQS9kczRuaFUrdnhYNnJpalIxTmxZVE9I?=
 =?utf-8?B?aC9HakpqbzhuVFhOeVkvbHJ5dW5HaEpPVWluR1FBWGlqVG1sZVl1QTd5ZDIv?=
 =?utf-8?B?QjNpL0VZeGtsSnEzSkp6c2w3RXlHQ1VYbmJoVm8wNitGWTlCanlLM2lxeUZm?=
 =?utf-8?B?NWRod09QQjJMYld4MzZ6dDVSbmw4WHpzUDBpeFIyRllQU2NiTmNXSkZvV2ta?=
 =?utf-8?B?dG43L01hVDYvU0hNU0hyN2VEMHl6OEViQTdTT1BhSGNKUEREUlpOWUlNM2JY?=
 =?utf-8?B?YzJVdTVJTzNla3p5eGo1TEV4ZHFUZ2R4YkkrZy9ONGlTaUJkSkQxV3R4TGpB?=
 =?utf-8?B?WkRreHdGc1RxMThndkxIRVBQRllBOXhXOW1hNEQrTkg2RDFsK2tmSlJYa29R?=
 =?utf-8?B?dUYwNE4xcVQzaDVoTU1jUDNINk9yT2JXYmdOL29jMVlxc1dUVTFsNnd3NXRz?=
 =?utf-8?B?NGVTQXE3R3BHL091cUtMQnVYaE5wUkhQenhGaUtEWEdwMnBHeHZYRFA4SjZa?=
 =?utf-8?B?a2lHcUZReXo2TUlXU0ZxeUxPY1Z2ZGI4ZjVGUUNzRVFOdzJyelQ3R1AyekZV?=
 =?utf-8?B?Mng1SWJpc1hzZnFpeDhUbitTd0p4OE5ZRWg0anhYclNBaTFjTWZTSWFLbE5U?=
 =?utf-8?B?dFlva1hYbEdrOU5aQ3ZFR0hpV3hRVDVQSHhBa2VLNWUrRklKaCtvelBSTzJK?=
 =?utf-8?Q?QSa34wAx/y6KQ2RqQxfCW0AQ/Q86izkw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Si9jQ3A1VjlidkFRU2hVVDBpNTZyNXdRZ0Z3L1JudWVIeFprMUxTVnpER3Zv?=
 =?utf-8?B?WTUzWE1ZZG9aTHRNL2FxQk5tc1JQQUdycno2bDIvckpjYjdBTHk0aVpIdmRu?=
 =?utf-8?B?bEg1MkMvbFcwVHJxeU1IaVphMG5zaFpHY3A1L3J3dlpWZFZTVzdUMnAxNzBh?=
 =?utf-8?B?RVVZMWg1cGg4OXYzbVlCQjkzRFF4TVJQcVY4MktSOGpHOXdKOUxMdWdCUFJK?=
 =?utf-8?B?cnQ5YkNLSEE0WG8rZUhINVM3eE03bndTdTFPWG1WaU9abnVwR0RxdnhseDNr?=
 =?utf-8?B?Wm9aNTZBWXJXendac3JQNlkrNkNCalJBNUlkM01nWEkxelVPTGRDQkxMckw2?=
 =?utf-8?B?NnlzQjhOUS9JajFpUGVpbi9NL2UzUzh3dThzejF5OXdSSG01Zlo3Tk5UK20r?=
 =?utf-8?B?NkNSMlI3QktMQzlpUzJUdk9HSmtlNGxGZFBvdFFsV2hTTjhqd2s0UHB6c1Bk?=
 =?utf-8?B?VnppSmJJbC9IK3EyU3JkWVZlYVRNZ1dudFozaXdPTFFNamlUZDFQZG1tVnR0?=
 =?utf-8?B?TnQ3bjZ1bTNYM0FRNVpyNTZvb0huSHpXclRRaUpVcVBMaS9aVm9weC8rbVlD?=
 =?utf-8?B?ZGM0MGZXQmlEalpnUDJIY2NjdS9UcXRCbUx5YnlxWW5QcjE4dVBKOXJOTTNS?=
 =?utf-8?B?V0h6Q0ZXY0JKYVZ1LzkxOTJteWUzZkRiYnhKNGdmT2xycnJPTnB6U3Fid1Rz?=
 =?utf-8?B?aTV4N0JsSW9lZ0ROK1VWejZjTitSUWtEelRCd0M1VlJlTktqNjZraysrYzhw?=
 =?utf-8?B?emVkMU5xVTV4TmJDN0dhRFh5a3ZaSDZSRG1td2FxMjVSNVFVNmRRLzJCU3dq?=
 =?utf-8?B?R09TZDhaSWNLT0ZwblNqc3ZJRU5wTmRpeFNZUlFDZmFoS3dTNWJCUnNpWitK?=
 =?utf-8?B?VUc4aHA3RCtsZHlhblRORXF4TENsZ2Vvc1lOd21tZ2xKVDBpemNkWStvbVcx?=
 =?utf-8?B?dFExNDVUajN1T1Bzd2gvdzFicVRnbCsycDQvS1doWFFQYXZsVkl5TEdCNU1z?=
 =?utf-8?B?clFPOXB0T1IvUTdGU1l6bUJTYVMvZ010Q3NtcjQ3cCtqTUE3RkNYdlRXUitX?=
 =?utf-8?B?dXFIcWNTTHFnTmpLaHVsOFJEZ1g0R1hmdmJsdTA0Mm82WGJlMkF4N2JvTll0?=
 =?utf-8?B?NmZPdFhQWXR3S1JYRkptS1NiT0pQLy9ad2luZjBtVVhnSUl1Vk5hUDB6OU9E?=
 =?utf-8?B?dWdLVmFRcXNiNC9GLyttZzdnaUEybXhSenE3N0N4WEZVNWdWYVh4NmlVNVpM?=
 =?utf-8?B?V1BHV1ZzUnFLdjJsZU11a25DNjdBR2Y3RmRjUVFtWE15alA5SUlHUkRGeXJJ?=
 =?utf-8?B?c1dlQS8vRFFKcStiSmVyWXNPaVNnYyt3MExuN29GQUVzbS9HZWxyNGh5VFlB?=
 =?utf-8?B?S1IyMkd0aTd3cGhUREZKZG45Y3F3bzMvbHlqZkRaU1BFYmR0QzU4eVR5Rksz?=
 =?utf-8?B?K1J2ZmZBTEhMQmhoM1ltemtBVWd4MWg3OE1YVWRCMnR3QlJRODNPV3F0UkJj?=
 =?utf-8?B?ODhjK0JoL3JwOElFd3ZQcWxmRXpOdnMxVFRUdFZBUkxLTlJlYWVYV0dLVVZs?=
 =?utf-8?B?ZXFXMUh1VlBvdHgwOEg4VXR3Z1grSUZFcmtqVzM5SFJNSmlDb3dEL1RkbjlU?=
 =?utf-8?B?WGpzYlVtdlJ2L2toQytzN3MycU9hSUVaMFd1YmlJMkFiUld2cUZCQVBUVUM2?=
 =?utf-8?B?Um1MR3RFR2pRYzhPWGhOL204SmJrWjNtK3FnUDJlckdDWFlITG5RaVM4b0M5?=
 =?utf-8?B?cEdGZHpMVTR6NVNpNHdoRStkNktQN04vUkNkR2U0d2t5R1lNWm12YS9JZUx3?=
 =?utf-8?B?YmIwZ2NKYk1tU0R4Z1YrN2xuWVBOZmMydExXRDdhZlNYSUxjaVBLS0pXK0xa?=
 =?utf-8?B?eVh2cUV4TnNLTlNEQWhGK1AzbUJ4U2V2ODNwamNNaTFDSjdvQjFXMEppSWxL?=
 =?utf-8?B?NHpGTCs2M0tRejgwQkQzYnorUzRvUXBEKzZ0SlVtZU9tS0pXOUJqUnpSYUN0?=
 =?utf-8?B?L2RCK3FVU0dUSHZ5alQvZUdCTUdYbTZBVDhMUTBITUU5WDV0ZFlQUk8zRWhP?=
 =?utf-8?B?ZmxUdmJCVWdqM3FhR2U5aXRyWFZteGZxeTBkbVkrYnlOQityRHdab1dkRjhu?=
 =?utf-8?Q?7yMoOMLDu5pyVmbLeHmhqZNBF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05C2D6E34674174E957826BC50C37F45@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gX59TD2pP6AJWzVEyiG0SsuHNXK8xciUCj5cIe2hi8KZOA9xBEHnicXSZ3fI+aiouxzHCT4yfCII7Gxu/KiSD2UUYuRbU8bvG4BYvuoz3KuUCKLGqE87urN3rywM26J84E3CwrC60CNdlzS3LB75fxSalpBQeNjTXRNeZRQe5cQzn4d1WASznuRGBV7sE+ehPHULvbYHCpFd5gwK0Uwd96Jj8SdXHnX061J34nGKZ2U1grLhR3kkfAlFomPZCTgBM/WOUoPUZkoxTYOquWP4dsUZ8pQqtNw/nQr/0V23p3YS4cXSMZwakTyamJXH6Qsw4vtVGmpUU41S/y+8KMG50a+ME1RtxihU1dRM13QKxIaVcmrOYplOJs2SBqiRXHIu/dLywVdwoafjIbMnybpChN+drfZ2qocfI2P0T2lal++NQRpfbAV2ku+CUMFIi4xMTM6TeLE+3mJuRrgTxrdeJRYDxF3PppUhVHyVIBzkYMkp5GMV5kCQuQvHDJit/Hm7xV63elVEpzwpfGDXvnJd6L7QTg7+1GiwlvS/MALTs2dsnO6PRC68P7Mfwh41D9TzbU2kabEflide+zWX0MVz6kVGDh30OPrxtGiVWGygLJ2Kv9mjWAYiZuB9s5ZuHK7iDYMksMLw3WvjHGXH7uvayA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9f0b81-6135-4d90-168e-08dd4b02033b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 01:10:17.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsbKd445BHqpN+oZZKmo+NyddFPQSXXouUFomgeP4vvWd/lbqjsgL6pbqkT5+V542tbcFZ1NJRA2Q4i9+Hwl4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
X-Authority-Analysis: v=2.4 cv=NJ0v+16g c=1 sm=1 tr=0 ts=67abf4ff cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=QyXUC8HyAAAA:8 a=_M0eQ0wog90XZHfFkOkA:9 a=QEXdDO2ut3YA:10 a=oEMVEZ3i_RgsLWMmMGl5:22
X-Proofpoint-GUID: wb7JG7X6rSDITQ-FcbViEvKlcIvhGr6s
X-Proofpoint-ORIG-GUID: wb7JG7X6rSDITQ-FcbViEvKlcIvhGr6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120007

T24gTW9uLCBGZWIgMDMsIDIwMjUsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gVGhlIHNucHMs
cmVzZXJ2ZWQtZW5kcG9pbnRzIHByb3BlcnR5IGxpc3RzIHRoZSByZXNlcnZlZCBlbmRwb2ludHMN
Cj4gdGhhdCBzaG91bGRuJ3QgYmUgdXNlZCBmb3Igbm9ybWFsIHRyYW5zZmVycy4gQWRkIHN1cHBv
cnQgZm9yIHRoYXQNCj4gdG8gdGhlIGRyaXZlci4NCj4gDQo+IFdoaWxlIGF0IGl0LCBtYWtlIHN1
cmUgd2UgZG9uJ3QgY3Jhc2ggYnkgYSBzdWRkZW4gYWNjZXNzIHRvIHRob3NlDQo+IGVuZHBvaW50
cyBpbiB0aGUgZ2FkZ2V0IGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNo
ZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA2MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGQyN2FmNjVlYjA4YS4uOTNiMWUzODlhOTgz
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTU0Nyw2ICs1NDcsNyBAQCBzdGF0aWMgaW50IGR3
YzNfZ2FkZ2V0X3NldF94ZmVyX3Jlc291cmNlKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICBpbnQg
ZHdjM19nYWRnZXRfc3RhcnRfY29uZmlnKHN0cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVkIGludCBy
ZXNvdXJjZV9pbmRleCkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjM19nYWRnZXRfZXBfY21kX3BhcmFt
cyBwYXJhbXM7DQo+ICsJc3RydWN0IGR3YzNfZXAJCSpkZXA7DQo+ICAJdTMyCQkJY21kOw0KPiAg
CWludAkJCWk7DQo+ICAJaW50CQkJcmV0Ow0KPiBAQCAtNTYzLDggKzU2NCwxMyBAQCBpbnQgZHdj
M19nYWRnZXRfc3RhcnRfY29uZmlnKHN0cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVkIGludCByZXNv
dXJjZV9pbmRleCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCS8qIFJlc2V0IHJlc291cmNl
IGFsbG9jYXRpb24gZmxhZ3MgKi8NCj4gLQlmb3IgKGkgPSByZXNvdXJjZV9pbmRleDsgaSA8IGR3
Yy0+bnVtX2VwcyAmJiBkd2MtPmVwc1tpXTsgaSsrKQ0KPiAtCQlkd2MtPmVwc1tpXS0+ZmxhZ3Mg
Jj0gfkRXQzNfRVBfUkVTT1VSQ0VfQUxMT0NBVEVEOw0KPiArCWZvciAoaSA9IHJlc291cmNlX2lu
ZGV4OyBpIDwgZHdjLT5udW1fZXBzOyBpKyspIHsNCj4gKwkJZGVwID0gZHdjLT5lcHNbaV07DQo+
ICsJCWlmICghZGVwKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJZGVwLT5mbGFncyAmPSB+
RFdDM19FUF9SRVNPVVJDRV9BTExPQ0FURUQ7DQo+ICsJfQ0KDQpQbGVhc2Uga2VlcCBjb2RlIHJl
ZmFjdG9yaW5nIGFzIGEgc2VwYXJhdGUgcGF0Y2guDQoNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAg
fQ0KPiBAQCAtNzUxLDkgKzc1NywxMSBAQCB2b2lkIGR3YzNfZ2FkZ2V0X2NsZWFyX3R4X2ZpZm9z
KHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIAlkd2MtPmxhc3RfZmlmb19kZXB0aCA9IGZpZm9f
ZGVwdGg7DQo+ICAJLyogQ2xlYXIgZXhpc3RpbmcgVFhGSUZPIGZvciBhbGwgSU4gZXBzIGV4Y2Vw
dCBlcDAgKi8NCj4gLQlmb3IgKG51bSA9IDM7IG51bSA8IG1pbl90KGludCwgZHdjLT5udW1fZXBz
LCBEV0MzX0VORFBPSU5UU19OVU0pOw0KPiAtCSAgICAgbnVtICs9IDIpIHsNCj4gKwlmb3IgKG51
bSA9IDM7IG51bSA8IG1pbl90KGludCwgZHdjLT5udW1fZXBzLCBEV0MzX0VORFBPSU5UU19OVU0p
OyBudW0gKz0gMikgew0KPiAgCQlkZXAgPSBkd2MtPmVwc1tudW1dOw0KPiArCQlpZiAoIWRlcCkN
Cj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICAJCS8qIERvbid0IGNoYW5nZSBUWEZSQU1OVU0gb24g
dXNiMzEgdmVyc2lvbiAqLw0KPiAgCQlzaXplID0gRFdDM19JUF9JUyhEV0MzKSA/IDAgOg0KPiAg
CQkJZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1RYRklGT1NJWihudW0gPj4gMSkpICYNCj4g
QEAgLTMzOTUsMTQgKzM0MDMsNTIgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9pbml0X2VuZHBv
aW50KHN0cnVjdCBkd2MzICpkd2MsIHU4IGVwbnVtKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAg
DQo+ICtzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3BhcnNlX3Jlc2VydmVkX2VuZHBvaW50cyhzdHJ1
Y3QgZHdjMyAqZHdjLCBjb25zdCBjaGFyICpwcm9wbmFtZSwNCj4gKwkJCQkJCXU4ICplcHMsIHU4
IG51bSkNCj4gK3sNCj4gKwl1OCBjb3VudDsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJaWYgKCFk
ZXZpY2VfcHJvcGVydHlfcHJlc2VudChkd2MtPmRldiwgcHJvcG5hbWUpKQ0KPiArCQlyZXR1cm4g
MDsNCj4gKw0KPiArCXJldCA9IGRldmljZV9wcm9wZXJ0eV9jb3VudF91OChkd2MtPmRldiwgcHJv
cG5hbWUpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArCWNvdW50ID0g
cmV0Ow0KPiArDQo+ICsJcmV0ID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfdThfYXJyYXkoZHdjLT5k
ZXYsIHByb3BuYW1lLCBlcHMsIG1pbihudW0sIGNvdW50KSk7DQoNCldoeSBkbyBtaW4obnVtLCBj
b3VudCk/IENhbiB3ZSBqdXN0IHB1dCB0aGUgc2l6ZSBvZiB0aGUgZXBzIGFycmF5IGFzDQpzcGVj
aWZpZWQgYnkgdGhlIGZ1bmN0aW9uIGRvYy4NCg0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiBy
ZXQ7DQo+ICsNCj4gKwlyZXR1cm4gY291bnQ7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdj
M19nYWRnZXRfaW5pdF9lbmRwb2ludHMoc3RydWN0IGR3YzMgKmR3YywgdTggdG90YWwpDQo+ICB7
DQo+ICsJY29uc3QgY2hhcgkJCSpwcm9wbmFtZSA9ICJzbnBzLHJlc2VydmVkLWVuZHBvaW50cyI7
DQo+ICAJdTgJCQkJZXBudW07DQo+ICsJdTgJCQkJZXBzW0RXQzNfRU5EUE9JTlRTX05VTV07DQoN
CkNhbiB3ZSByZW5hbWUgZXBzIHRvIHJlc2VydmVkX2Vwcy4NCg0KPiArCXU4CQkJCWNvdW50Ow0K
PiArCXU4CQkJCW51bTsNCj4gKwlpbnQJCQkJcmV0Ow0KPiAgDQo+ICAJSU5JVF9MSVNUX0hFQUQo
JmR3Yy0+Z2FkZ2V0LT5lcF9saXN0KTsNCj4gIA0KPiArCXJldCA9IGR3YzNfZ2FkZ2V0X3BhcnNl
X3Jlc2VydmVkX2VuZHBvaW50cyhkd2MsIHByb3BuYW1lLCBlcHMsIEFSUkFZX1NJWkUoZXBzKSk7
DQoNCkJhc2Ugb24gdGhlIG5hbWUgb2YgdGhpcyBmdW5jdGlvbiwgSSB3b3VsZCBleHBlY3QgdGhl
IHJldHVybiB2YWx1ZQ0KdG8gYmUgYSBzdGF0dXMgYW5kIG5vdCBhIGNvdW50LiBTaW5jZSB3ZSBh
cmUgbm90IHJlYWxseSBwYXJzaW5nIGJ1dA0KZ2V0dGluZyB0aGUgcHJvcGVydHkgYXJyYXkuIENh
biB3ZSByZW5hbWUgdGhpcyB0bw0KZHdjM19nYWRnZXRfZ2V0X3Jlc2VydmVkX2VuZHBvaW50cygp
Pw0KDQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJZGV2X2Vycihkd2MtPmRldiwgImZhaWxlZCB0
byByZWFkICVzXG4iLCBwcm9wbmFtZSk7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArCWNv
dW50ID0gcmV0Ow0KPiArDQo+ICAJZm9yIChlcG51bSA9IDA7IGVwbnVtIDwgdG90YWw7IGVwbnVt
KyspIHsNCj4gLQkJaW50CQkJcmV0Ow0KPiArCQlmb3IgKG51bSA9IDA7IG51bSA8IGNvdW50OyBu
dW0rKykgew0KPiArCQkJaWYgKGVwbnVtID09IGVwc1tudW1dKQ0KPiArCQkJCWJyZWFrOw0KPiAr
CQl9DQo+ICsJCWlmIChudW0gPCBjb3VudCkNCj4gKwkJCWNvbnRpbnVlOw0KPiAgDQo+ICAJCXJl
dCA9IGR3YzNfZ2FkZ2V0X2luaXRfZW5kcG9pbnQoZHdjLCBlcG51bSk7DQo+ICAJCWlmIChyZXQp
DQo+IEBAIC0zNjY5LDYgKzM3MTUsOCBAQCBzdGF0aWMgYm9vbCBkd2MzX2dhZGdldF9lbmRwb2lu
dF90cmJzX2NvbXBsZXRlKHN0cnVjdCBkd2MzX2VwICpkZXAsDQo+ICANCj4gIAkJZm9yIChpID0g
MDsgaSA8IERXQzNfRU5EUE9JTlRTX05VTTsgaSsrKSB7DQo+ICAJCQlkZXAgPSBkd2MtPmVwc1tp
XTsNCj4gKwkJCWlmICghZGVwKQ0KPiArCQkJCWNvbnRpbnVlOw0KDQpJdCBzaG91bGQgYmUgZmlu
ZSB0byBpZ25vcmUgdGhpcyBjaGVjayBoZXJlLiBTb21ldGhpbmcgbXVzdCBiZSByZWFsbHkNCndy
b25nIGlmIHRoZXJlJ3MgYW4gaW50ZXJydXB0IHBvaW50aW5nIHRvIGFuIGVuZHBvaW50IHRoYXQg
d2Ugc2hvdWxkbid0DQpiZSB0b3VjaGluZy4gSWYgd2UgZG8gYWRkIGEgY2hlY2ssIHdlIHNob3Vs
ZCBwcmludCBhIHdhcm4gb3Igc29tZXRoaW5nDQpoZXJlLiBCdXQgdGhhdCBzaG91bGQgYmUgYSBw
YXRjaCBzZXBhcmF0ZSBmcm9tIHRoaXMuDQoNCj4gIA0KPiAgCQkJaWYgKCEoZGVwLT5mbGFncyAm
IERXQzNfRVBfRU5BQkxFRCkpDQo+ICAJCQkJY29udGludWU7DQo+IEBAIC0zODE4LDYgKzM4NjYs
OCBAQCBzdGF0aWMgdm9pZCBkd2MzX2VuZHBvaW50X2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdj
LA0KPiAgCXU4CQkJZXBudW0gPSBldmVudC0+ZW5kcG9pbnRfbnVtYmVyOw0KPiAgDQo+ICAJZGVw
ID0gZHdjLT5lcHNbZXBudW1dOw0KPiArCWlmICghZGVwKQ0KPiArCQlyZXR1cm47DQoNClNhbWUg
aGVyZS4NCg0KTG9va3MgbGlrZSB0aGUgb25seSBOVUxMIGNoZWNrIG5lZWRlZCBpcyBpbg0KZHdj
M19nYWRnZXRfY2xlYXJfdHhfZmlmb3MoKS4NCg0KPiAgDQo+ICAJaWYgKCEoZGVwLT5mbGFncyAm
IERXQzNfRVBfRU5BQkxFRCkpIHsNCj4gIAkJaWYgKChlcG51bSA+IDEpICYmICEoZGVwLT5mbGFn
cyAmIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCkpDQo+IC0tIA0KPiAyLjQzLjAucmMxLjEzMzYu
ZzM2YjUyNTVhMDNhYw0KPiANCg0KDQpUaGFua3MsDQpUaGluaA==

