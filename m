Return-Path: <linux-kernel+bounces-213086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E707906AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F3C1C231E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555FA143879;
	Thu, 13 Jun 2024 11:23:10 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F0143724;
	Thu, 13 Jun 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277789; cv=fail; b=gm+etGO5On0g74j2hMDSmSniTX0tvC9KHVuAEF3aL+jL8oN+rAk+IZYkJIE0T9cClAYvTTo9hSLAnStVg88KrDWW9eUQ4XkpZhHI2Z3IuTyTrVjjguK6xaA6cX77NO3yGugYuUi1QI6Y1/Z41+fbVGZ4IiJQTl398gvq1q7tFRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277789; c=relaxed/simple;
	bh=0ndlHaG/Yx27VKnL66zMDlUN14wYhv3+csrAd2F578Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FzKTFk502H3C93XtvmhWYvjw7khO3g9OC8QXntJ02q9gJKhkA3WFHmUJVol8sxq9F/4VyObcobs9Bz46aljEmoite2OkY/c8hLZDolHPTnhsi/9THaFEKeYNHs2+6aGq1LwkE/qFvVaXAZeyBF9cBUK2PsPR89mHj53OA0lNQiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D4Z1sb001500;
	Thu, 13 Jun 2024 04:23:01 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ymjk2cyuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 04:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9sZ19im9lZ3BE5ECQ3YUygUeZy+Uj/OAJrCMuYdohqws2iAEqeCv+JcG3mMI9fnPOPhyC3fdlwFHps2MFNWFK93UqmXnZHhSht7IpxbQOjn1mEL7KBuItas/aqPAumHD9SpbKRlgQe5Q7fqoSsYm7d9h6Adb3VRgOjN+5nwESSeKyEl1DiDle/lpfzAT0szuXxxAY/n5GmyzUTQC6DWlsbfvw8Ca742gZqByf6uhCUMG6XCvFQabU67FhhZyDGuIC4mYI5BB1b+eoPSZt8zWDd7tIgi1F0XUcnk9rnymlPcjUP25itrYye+SF91K6nQbuKxxJZ4e/qrCLkXP3ReAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ndlHaG/Yx27VKnL66zMDlUN14wYhv3+csrAd2F578Q=;
 b=bmpgIPIczZtdnqipLcyw5egkyY+dGOf8ZG7E5B/0NxXnrOFPBMOmKz3NNNFTN234HJ8nZ9I6f4Df/yLDZC32jAstDgRpZR20RlMhDyT9mpL/DOr9ItBT3YUXmI2rAKAleQ/ewwxmrYkprH/o9H5feaJB/JmZmzuodw2DLmXszqjrBAvNNNl63/N9N1+ATuA6rDv1saGD7m/eqb/ChUQLEy2ltWr3DIZcjS1oIn57VqW/WGTT7Y7ZRBilzXxsnXw1FBFBV9VdqxvJYQR+a+iC4I07MK2ySaA5X2LtC468Pdv8RrIC11mglZRnj2OnRJdKfPTsMjcEWy57biT3CqA1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 11:22:57 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9%3]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 11:22:57 +0000
From: "Li, Meng" <Meng.Li@windriver.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "Thinh.Nguyen@synopsys.com"
	<Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "quic_uaggarwa@quicinc.com"
	<quic_uaggarwa@quicinc.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Topic: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Index: AQHavWKU0485a3wnY0+iuiKoykc8vrHFY1UAgAAjC+A=
Date: Thu, 13 Jun 2024 11:22:56 +0000
Message-ID: 
 <PH0PR11MB5191030225F3A871EB0836AEF1C12@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20240613072310.1927966-1-Meng.Li@windriver.com>
 <69839983-5ec0-4207-a798-8cdac7444f20@kernel.org>
In-Reply-To: <69839983-5ec0-4207-a798-8cdac7444f20@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|SJ0PR11MB5772:EE_
x-ms-office365-filtering-correlation-id: 4cbe78f3-28ef-41d8-5222-08dc8b9b2cf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|366010|376008|1800799018|38070700012;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bitDRzBLWmpVcUp1UG84YWtVSE41dlNPVHQ3SDJhZ0xlMG5hbXNBSWFuZFRB?=
 =?utf-8?B?aDVHVHZzUHFYa2JOVHBUSzZZWG9UZjF6dE5QSEFtYUVPNmRrZ1JYci9RdDda?=
 =?utf-8?B?S3FxanpXYTIvdlhBSmNNNmo3QUN5b0NkN20xVjRUZmJ4bXNqWjBEcWVzYS9E?=
 =?utf-8?B?MVZNNFlIdHRsMjVtdDVaMFM0ZXU3RlFFTEFZeDBRdXhBdW95VGRDTFVFaWds?=
 =?utf-8?B?MnovOXJuZXZGd0YzQ2UyeEM0NTE3MEhUUUpZSjdaQThMSWRrUXBZM213VTN3?=
 =?utf-8?B?ZDh6TDFYMjg4c2NtZlVUMm9pQkJlSHRaQUFnZEhDT1BhR05XanhYRWIvbUNQ?=
 =?utf-8?B?MG9EYzI4QmRsWmlPZzZYS1VHUHo3YTlOYUx5c3BpZzNzSzZkU1JreE5kQmMz?=
 =?utf-8?B?YUcwRDI0SDNjVDRvTlBUSEY1UEdDRjJzeFFkZDhpcVBOOU03aVBBK0NWL2ZP?=
 =?utf-8?B?bzhiUmF0NU5mN25mMVp2WFRiZERTNnBNQUJMSHNzNEFrK0FnTVBiSTgyTWpy?=
 =?utf-8?B?czd4U3hpUExMVDk5TElpSTMvQVRWSHNEeXZvbUhjRWlmVlhlaGNuREdwSWh3?=
 =?utf-8?B?azlscmtoeEloSjl4UlBEWERWR1hmOTNZNURTZHpHSFE1QmRXckFvbTRXN3RE?=
 =?utf-8?B?bUM4RzZzRWZMTkMzNjgvVSszNzlTbGJXL3JUUW02OWQrTC91bWJGVG01bThC?=
 =?utf-8?B?eGxPUUNvbGFObHZUQzlKS1VYUXN2REROS1lYSmM5UjlqR2FocEdxVWl5M2Jn?=
 =?utf-8?B?OW8wamEyRkYvMDRUTkMxOExWZVdpbUVRYm9POWtFemhRcHZCUkdHeEhJOS9l?=
 =?utf-8?B?VVM2VnNxK2IzVFBPRm90cjNRMi9WdEJlSlI0SzhQYWw2T0RPWGlIekhrMmlO?=
 =?utf-8?B?bzRxRmc0V0NHbWNzb3RjL09uUDkvOTJ3Zjhra1grdU5jS2RxTW1kZnBhcmw4?=
 =?utf-8?B?aXJmeUZ5ZEd0bksxTmh4Z0V4NFd6VkRnQkg5bTBWTWlFc0o1dUIvVTRMVGJW?=
 =?utf-8?B?VWFTc0dJZElsRUI3N2lJMGZlcVpJU3dzaEN6WlpKWjlUcG8rU09zVzJ6cjFl?=
 =?utf-8?B?R0Jwd3lUYlBoYytUem1DQnVHNjUzZURLL1B6TmxFVThFTnhVckVMeUl6ZHVz?=
 =?utf-8?B?dFB2SjVXZWgrMWRYUWc4VUV4R2FlekRVMlBVcXNSU2QrUVZRUGR5NUhHVUN2?=
 =?utf-8?B?T1IvK1UvVFVwNlhxbGpaNlFyaGM5N3VEUXJmNFNUSUp2c3I1dml4bldNTFN1?=
 =?utf-8?B?bFNPTVByRzE1VStPWU1iaCt0QjZzQUg3NkFrTHhkMFlXcytkcXZrWk5mMzdM?=
 =?utf-8?B?TDFHaW1DMktYNGVRQ2dNQzFhcDc3eDdRL29JVWxtL0xGRUF1Y0ZMbTU4clRR?=
 =?utf-8?B?ODNUMHVDaDF4eTM3cDA3bDRja0tnNXpOVEYvWXRSbHZMbnNidU1BVHd2MjUv?=
 =?utf-8?B?Ry9icG1zVkNGbFNNV0ZxbGl6aGozaVI4KzVTQ2luYUxaNWkvMVpoRGtxaGVy?=
 =?utf-8?B?blExcExLQVhIQTNRU3JQOE4xNEVkMUVMZjJvNUJSU2kwZXhIa0tZZ0Uwby95?=
 =?utf-8?B?Y080MmdqVFQwdHpUN01lUmFqdXF5d2hmTzNVVnBaYnY5cXRIQ2o5bmZzUU0z?=
 =?utf-8?B?Q1U4RXRaeU5FUTNFbS9OQVhUTXJjUTVKNHFuWncva25sZG1KUCsrWCtmK2Ri?=
 =?utf-8?B?UnZaOWx0RkhuV0x2WHV1NEhQS2JVU2h4VlZoSUFsTlF6djc3ZVdDRHNmaEF1?=
 =?utf-8?B?dzFwSitoYSsyVnl4K0tLbHVDZkk2TkhSby8zQnZGVWhVZHdXblJYOU9OZ3Bq?=
 =?utf-8?Q?4I8KgRFjO3BGmq+W//r++KDqSksVGJ1Gk5fU4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018)(38070700012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K0txS1F1MkxDRTZmR0dJSi92ZTBFMllkZjBINDV0d29Za0UybTFmdHlUcWY2?=
 =?utf-8?B?cFdJNlRwRjNPZHgwbUdiQUw3VmUxVnNMU09uM2IrcStxbnYxRlJoN0RwYWpn?=
 =?utf-8?B?RzhhUkdBVUdMU0g2azl2ZXVnZXVadlV1aTVTWUUwYnorSFRualI4YUF2dG5D?=
 =?utf-8?B?K21PRHliSW9SaWxyLzdjelVCTllKa09QQ1ZLUnpwNzFqVTJyU2d3L3o3SnFQ?=
 =?utf-8?B?a2tRQUhFRk90ZTNadVY0MWRVSS9mNWhsa0VhMGdaMFI0QnJiWEVVZTMxTWRz?=
 =?utf-8?B?dHFlL3hMdlZiMDZyd2Y4cXFPcDBXRW9reHVxb0dPRTZCZDBWeU8wZm1YeHVL?=
 =?utf-8?B?dkF4NWJqYmRHSTlOb2IvUE1ROTlWV056YTM4cU1wUmxSbkRGSlZoUVhRMTla?=
 =?utf-8?B?TXJoKzlEaGlIKzZ5Sy9FdXV5a3BJSHZRcVhTRkMrWlNmZ1Bvc0UzWHlHdWdV?=
 =?utf-8?B?ZW9QS2dlMGNqTnVQak14RWVUUm96VjFOaWRGTkcrMGt0RE5ZSnVjanU0cEtv?=
 =?utf-8?B?Umc5S3hJUmg2eGdmamVYQTJFR1hMVHhnaWg5dkxlTUpMbnVybWl4TmdpcjNt?=
 =?utf-8?B?YVo4cy9BSmxoK1ZPWkFKSktNL2RCeHdHckk2ZTNscHlKVVYvZzRtdHlHWEEy?=
 =?utf-8?B?TlpPK29RSENEYzJIaEdHSnFEVXNWNXlJWVR3c2U5TVpxK2c0Z1FROUlqVFpB?=
 =?utf-8?B?UWdaK0hxZCtmR3FYOVN2Y3VZSUYyUmNiNHJGQXFYYU5KZS9YNTJELzUyZEp6?=
 =?utf-8?B?aUVubVI5R2tZQmdnUDZYSGFmUjhsdTdFUlVPUzAyMkRFdWlQalNhd3BvOFph?=
 =?utf-8?B?emJZNGMxOE1HR2JoYkxNZUcyY0hhTVhaR0ZUcWlpZEpPTk5oRHRKaFJxbnBV?=
 =?utf-8?B?MGlicnI2OHhBM0JxVmMyTHIyR1h5K0lBMlo5Q2liTlM4ajBFQ1dvZitvYlcz?=
 =?utf-8?B?VFd5VC9nM0xJTVJLVUp2WGlxTnhpWFp2NHFyaTBRcVJKaitVU1UvQVNINkdI?=
 =?utf-8?B?Q1BtdVhzUjloa0xTcFFhSGZpUEo0Z0QvQ2xhOHlGL2ZXMldraEYxcjVXdU4w?=
 =?utf-8?B?Z3RqeWtuOERSa2Nlc2xHa0FUZjl0d0c2MjU2endZZVFCdERxLzdDNW9WQUxX?=
 =?utf-8?B?bkpabnFYVy9XSFhrOGtReE00U05JSEJ4ckY0UWFiTWRXSSsrSmlISCtmU3Na?=
 =?utf-8?B?RnlOY2ErUWp3U2FRNTh5WlVCWHYyT0dCdDhBOVZOczRqUWc0MFdDaGhUWVho?=
 =?utf-8?B?V0VoUkFzUTNHU0hGOHVyNWZvbUZ4SWlDdk1vMjVNM0JncCtKZ0pXZW95Q0ti?=
 =?utf-8?B?enBJNENTU0tORjE1WkZDWklhREpiQ0hvN2xDUkVDbkFlR2NZS0pGS2dRUXJV?=
 =?utf-8?B?S0dkWC9oMDJLLzFhQkN2dU1zNVo4Szhmd0FDTGdnWmZIdVNPeXRrcUhJQTE2?=
 =?utf-8?B?SHd3Zmo5RGozaVBqdFZObDZoa2ZJOENxQzRKWGRyRlRqNzJEUGxtRnNHcTFa?=
 =?utf-8?B?WVlwZ3loSXM0bEwwTStiTVNYNlRsK2N0UlJ4UVdkQy90NWJ3SDdxRUZXLzBJ?=
 =?utf-8?B?dHpxWkdVemJNT21WMkhCakREOURWbExTWU9IWmx2a3ZJNVNLS1VRbnk3WWlk?=
 =?utf-8?B?bUM4ZWRQRXJVdzh0bWdZVWlEd04yNjNrMk5FQVBGVUdMT1pOZjRFZFc1QXRK?=
 =?utf-8?B?dTJIRFVrRUlFM1ZJRHZsNmdpOGROZURlMld5Qitjbms5RFFqUVpkQzNabmpL?=
 =?utf-8?B?YnZ1d0IrMHBCdjNnNkhidUFoQUZhWGpKaVAwdExGc1M3NHRwN3JLTVlIUFhq?=
 =?utf-8?B?N0FtcUxTMHh5OVJLZlk1NVJ0ZGdqVEpkbUkxMW9MRkgvOG9sUlBuSTJYVTVy?=
 =?utf-8?B?bzRpcWpWV3pHTTVpWVM2N2JHYyszU2VLZEdQcHNnY3FQb0x6VXFWMUJYWXJq?=
 =?utf-8?B?c2gvYmJkNTdxdjlrRm5wY1pJd2NYUldDMUFVTXR4UTB4Q2Q5TTB3Zkw5cWdn?=
 =?utf-8?B?MWJQOVl0ZFdKZUtkVXpTNEFlc1pXSEhZOTFmSjlHRHBvVVgrNkNvZ1ErVkZY?=
 =?utf-8?B?RDhraGZHYzlwRTlFUlpkTkprVUxjaVRXaWwycUFid3NmWCtCSGZNNnZtMFcr?=
 =?utf-8?Q?0Fe+loEyjR/qX93UYNK1GCjj+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbe78f3-28ef-41d8-5222-08dc8b9b2cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 11:22:57.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwIzgvI87URLDRQPOxLrLtVbta8Sqejun7Lq6AHaHJPCkO2T3eqPDZpoWredWKCBjGttHjOTLJRV3EpQwR7lnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-Proofpoint-ORIG-GUID: k6XEq_vPUYutaxbU0fqw1gyzhbaupi3C
X-Proofpoint-GUID: k6XEq_vPUYutaxbU0fqw1gyzhbaupi3C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_03,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406130082

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxMywgMjAyNCA0
OjUzIFBNDQo+IFRvOiBMaSwgTWVuZyA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPjsgVGhpbmguTmd1
eWVuQHN5bm9wc3lzLmNvbTsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHF1aWNfdWFn
Z2Fyd2FAcXVpY2luYy5jb207IGxpbnV4LQ0KPiB1c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZHdjMzog
Y29yZTogcmVtb3ZlIGxvY2sgb2Ygb3RnIG1vZGUgZHVyaW5nIGdhZGdldA0KPiBzdXNwZW5kL3Jl
c3VtZSB0byBhdm9pZCBkZWFkbG9jaw0KPiANCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBjb21lcyBm
cm9tIGEgbm9uIFdpbmQgUml2ZXIgZW1haWwgYWNjb3VudCENCj4gRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQN
Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gT24gMTMvMDYvMjAyNCAwOToyMywg
TWVuZyBMaSB3cm90ZToNCj4gPiBXaGVuIGNvbmZpZyBDT05GSUdfVVNCX0RXQzNfRFVBTF9ST0xF
IGlzIHNlbGVjdGVkLCBhbmQgdHJpZ2dlcg0KPiBzeXN0ZW0NCj4gPiB0byBlbnRlciBzdXNwZW5k
IHN0YXR1cyB3aXRoIGJlbG93IGNvbW1hbmQ6DQo+ID4gZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0
YXRlDQo+ID4gVGhlcmUgd2lsbCBiZSBhIGRlYWRsb2NrIGlzc3VlIG9jY3VycmluZy4gQmVjYXVz
ZQ0KPiA+IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoKSBhbHNvIHRyeSB0byBnZXQgdGhlIGxvY2sgYWdh
aW4gd2hlbiBwcmV2aW91cw0KPiA+IGludm9rZWQgZHdjM19zdXNwZW5kX2NvbW1vbigpIGhhcyBn
b3QgdGhlIGxvY2sgLiBUaGlzIGlzc3VlIGlzIGludHJvZHVjZWQNCj4gYnkgY29tbWl0IGM3ZWJk
ODE0OWVlNSAoInVzYjogZHdjMzoNCj4gPiBnYWRnZXQ6IEZpeCBOVUxMIHBvaW50ZXIgZGVyZWZl
cmVuY2UgaW4gZHdjM19nYWRnZXRfc3VzcGVuZCIpIHRoYXQNCj4gPiByZW1vdmVzIHRoZSBjb2Rl
IG9mIGNoZWNraW5nIHdoZXRoZXIgZHdjLT5nYWRnZXRfZHJpdmVyIGlzIE5VTEwgb3INCj4gPiBu
b3QuIEl0IGNhdXNlcyB0aGUgZm9sbG93aW5nIGNvZGUgaXMgZXhlY3V0ZWQgYW5kIGRlYWRsb2Nr
IG9jY3VycyB3aGVuDQo+IHRyeWluZyB0byBnZXQgdGhlIHNwaW5sb2NrLg0KPiA+IFRvIGZpeCB0
aGUgZGVhZGxvY2sgaXNzdWUsIHJlZmVyIHRvIGNvbW1pdCA1MjY1Mzk3Zjk0NDIoInVzYjogZHdj
MzoNCj4gPiBSZW1vdmUNCj4gPiBEV0MzIGxvY2tpbmcgZHVyaW5nIGdhZGdldCBzdXNwZW5kL3Jl
c3VtZSIpLCByZW1vdmUgbG9jayBvZiBvdGcgbW9kZQ0KPiA+IGR1cmluZyBnYWRnZXQgc3VzcGVu
ZC9yZXN1bWUuDQo+IA0KPiBUaGF0J3MgYSBmdW5ueSB3YXkgb2YgZml4aW5nIGRlYWRsb2Nrczog
cmVtb3ZlIHRoZSBsb2NrLiBPZiBjb3Vyc2UgaXQgY291bGQgYmUNCj4gY29ycmVjdCB3YXkgd2l0
aCBzb21lIGp1c3RpZmljYXRpb24gd2h5IGxvY2tpbmcgaXMgbm90IG5lZWRlZC4NCj4gTm8gc3Vj
aCBqdXN0aWZpY2F0aW9uIGhlcmUsIHNvIGZvbGxvd2luZyB5b3VyIGxvZ2ljLCBsZXQncyByZW1v
dmUgbG9ja2luZw0KPiBldmVyeXdoZXJlIGFuZCB0aGVuIG5vIGRlYWRsb2NrcyBwb3NzaWJsZSEN
Cj4gDQoNCkkgZG9uJ3QgcmVtb3ZlIGxvY2sgYXJiaXRyYXJpbHkuIEkgaGF2ZSBzaG93IHRoZSBj
b21taXQgNTI2NTM5N2Y5NDQyLiBJdCBtb3ZlIHRoZSBzcGlubG9jayBmcm9tIGR3YzNfc3VzcGVu
ZF9jb21tb24oKSB0byBkd2MzX2dhZGdldF9zdXNwZW5kKCkgZm9yIGRldmljZSBtb2RlLCBidXQg
bWF5YmUgZm9yZ290IHRoZSBjYXNlIG9mIG90ZyBtb3ZlLg0KU28sIGNhdXNlIGRlYWRsb2NrIHdo
ZW4gZHdjM19nYWRnZXRfc3VzcGVuZCgpIHRyeSB0byBnZXQgdGhlIHNwaW5sb2NrIHRoYXQgaGFz
IGJlZW4gZ290IGJ5IGR3YzNfc3VzcGVuZF9jb21tb24oKS4gU28sIEkgdGhpbmsgaXQgYWxzbyBu
ZWVkcyB0byByZW1vdmUgdGhlIHNwaW5sb2NrIGZvciBvdGcgbW9kZS4NCg0KPiBMZXQgbWUgcHJl
cGFyZSBwYXRjaGVzIGZvciB0aGF0Li4uDQpJIHRoaW5rIHlvdSBjYW4gY29tbWVudCBvbiBwYXRj
aCwgcHJvcG9zZSBzb21lIGFkdmljZSwgcmF0aGVyIHRoYW4gbmVnYXRlIHRoZSBlZmZvcnQgb2Yg
b3RoZXJzIHdpdGhvdXQgYW55IGNvbW1lbnQgZGlyZWN0bHkuDQpBcyBhIG1haW50YWluZXIgb2Yg
c29tZSBwYXJ0cyBvZiBrZXJuZWwsIEkgdGhpbmsgeW91ciBjb21tdW5pY2F0aW9uIHN0eWxlIGlz
IG5vdCBmcmllbmRseSwgYW5kIG5vdCBjb25kdWNpdmUgdG8gZGV2ZWxvcGVycyBjb250cmlidXRp
bmcgdG8gdGhlIGNvbW11bml0eSwgYmVjYXVzZSB0aGVpciBlbnRodXNpYXNtIHdhcyBkYW1wZW5l
ZC4NCklmIHlvdSBjcmVhdGUgcGF0Y2gsIHBsZWFzZSBkb24ndCBmb3Jnb3QgdG8gc2VuZCB0byBt
ZSwgSSB3YW50IHRvIGxlYXJuIHdoYXQgZ29vZCBzb2x1dGlvbiB5b3Ugd2lsbCBzaG93LCBhbmQg
aG93IG11Y2ggYmV0dGVyIHRoYW4gdGhpcyBwYXRjaC4NCg0KUmVnYXJkcywNCk1lbmcNCg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

