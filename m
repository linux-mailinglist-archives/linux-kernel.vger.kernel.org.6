Return-Path: <linux-kernel+bounces-423864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FC59DAD9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4A728159B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7F201261;
	Wed, 27 Nov 2024 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="TnUmf+1G"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E27983A17;
	Wed, 27 Nov 2024 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735217; cv=fail; b=lEipgqJOI4qBg7efZCJDF2NrCUOD5Nvt2A8e12Sw4eCqZC4yEtkIACec3EFlIAGVy7b5He/oycQX+/WnpsK13g7QPkXV0/wX10/ZRvBXHwmeQn+X5isf5008NuKzTlMStxXTScHJ867ZFwX29PkeTF20vgPQuIFmjWwUDs4WAfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735217; c=relaxed/simple;
	bh=1f7oaXuG+HMkgCLqSpB7X5/sSgIWnVE6E28uJvEFuW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pgqj+EBKCMYzula2ICf2LiLYPQcjt0WyPtxZ6RQa9m64l/fhgtS1wXZ4kQPyRX0mq0doNVaDAVdabw55P2kxor+NToWvL/rsAwU9nOJ98rg5YoGWCjQdGCL+J7dDM+aSTei+refpawgK+RcONyc7XchswD4c4XiOy9GoABP3xsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=TnUmf+1G; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARJGWTB001595;
	Wed, 27 Nov 2024 19:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=1f7oaXu
	G+HMkgCLqSpB7X5/sSgIWnVE6E28uJvEFuW0=; b=TnUmf+1GZH0vP3gB+7CUQhE
	TwhHzL0J3QNNYSXPyaAX0kbObUDK2NjT0y8Hmr+ZIgbC33VPZ9vNxj5gqrqEeb3X
	ixjhf01B907VFChfeZFriQLcPcIQW+qzOE9NwNDnQvbxB5rCIsG9qP/3xyitVNUi
	UZAHXoGxQhgXYFj9Z9sqSgTWKkc40c58AmMpaG9P8qhvAcr+a8DIetV+y2nECQ69
	7RJuuZyK1sNxD4N44f0qu1ehzio2lGLf6NV2pJITH6oVNhyqc2zvuaxLiE0qg62w
	wvWLKfaAvUBM9pLBwGYYEvblPdC+kzbVL0FQ6jCLalZI7suEEqrGYBRA7yYc5Zg=
	=
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 436705r3nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 19:20:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA14LE+a5/hsfDAftE+hZvhYviBfic5jnY8z8lwNsqiMytL/5rJDqYVO1y6jKaikIL1USd6w7cbJHyvefKFr+uXBV0AYM/Lu7ujeDm8FE4DdFElLADt28fieh+Y7hJDDuYx4WUvkUO3/rtymTAnrUmPg+D8ZeZ2qC3KlZhTRycyKIeG7gH+2zB5HiyDoRY7DP8EhOhZvzNIAaD7bfyahpB3B27YJ4jBrXFxbUkyLosdvtIrYMpDc+Syyx0iNtr3Ejzy0xVSq01nlyv0+1A1eNSsIMr2zDNDH+iVYeUu7NpP0EzyRjNUktpNOFTjsUagfcsHsgd4Y2NjXsxIaMT7icA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f7oaXuG+HMkgCLqSpB7X5/sSgIWnVE6E28uJvEFuW0=;
 b=JnguAuIo0uEYrnau9UAQFGiFU6sK08U1efvWGlwcOz/ydj5ew16r1SuSYCW+5U5BdAMYB+XziwsDO6YJAwDz7Igh+qlC2grVFdiR3yuq1tzkpdzSlYHnOcvl7SsV2fzPFNdqPNj4/dG5jJX4mE6t3UqaUhnydu68ny7nttyJLZY2hjTY/M76CtUc2sgXKe0omm6bbJUzVjma8cdr6OTbLO2F+OBrOPrw/ysosKOeL/+0DGHRndiKvMs0ipvlznFMHl2wh8o82mPzbUr8eja1kyVlIi7t53EZADgdOoKh+V5RdZvSJGaUDM3s9MflKJoR5mc+mEGwTFNBs8+XY/023g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by SA1PR13MB6671.namprd13.prod.outlook.com (2603:10b6:806:3dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 19:20:01 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 19:20:01 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [boot-time] RFC grab-boot-data.sh - tool to grab boot time data
Thread-Topic: [boot-time] RFC grab-boot-data.sh - tool to grab boot time data
Thread-Index: AdswrWifVP76ayJTRMK7KCYJOs7oiwAOwD8ABAYdM1A=
Date: Wed, 27 Nov 2024 19:20:01 +0000
Message-ID:
 <MW5PR13MB563217F05913D7146437B395FD282@MW5PR13MB5632.namprd13.prod.outlook.com>
References:
 <MW5PR13MB5632F54DCBDA0C74370E531FFD5C2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAMuHMdWUMap1maZCmOqEqaxNWHKRiwg1QaN0W9j+8iPkPyHEMg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWUMap1maZCmOqEqaxNWHKRiwg1QaN0W9j+8iPkPyHEMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|SA1PR13MB6671:EE_
x-ms-office365-filtering-correlation-id: 889a84ef-833a-43e5-5479-08dd0f187d58
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGlvd2tsYU12YWxaeU9XMitXMFdDeDlzc0FOd3N4N3VsdTlsemxyNEV1a2J6?=
 =?utf-8?B?SW9hMHZSeDBVSFZURHpOcVZ3YUxaN3FrQWYyZVBpK0h3c25LWTlGZHRKKzh0?=
 =?utf-8?B?am5uM1FUb29YWHFOQW9GbGQwUHRnQUw1ZlBwbDZXQm5UakpYNnJTYitCZ2ph?=
 =?utf-8?B?QzZaMWZKU1ZCbVRiWWdWK2w5T3hZMVQ0OFRhZE9qcDY1MkJnTmNYejNjTWpu?=
 =?utf-8?B?Y1JQS0JTZ0d0VHZuTEcxNXY5TnJaeGsyTVIrTUhwWTFhR1R3VDFRaUluZHdZ?=
 =?utf-8?B?MGp4NUtoS05oL3lQSVljOTlTSlIxNExvdHE4RHlPVWwxdUxWc0lCc3FWVC9r?=
 =?utf-8?B?eGo5czRkR1grcUd3dFd2QmVsWDNNYXVTS3hGT0tlRWhVM1E3eFRRN0dyK1RW?=
 =?utf-8?B?ZS9UNnNCd3ROdDFNbHg4RXF5a1NyT0VDend0ZGJBSEIzL1lmdXF4NFNOSXZz?=
 =?utf-8?B?a2puWGhTM2xhQ1JvcFVFS2dLNjdaaVVKUUdxWVd5TERxQkhFTmZWN3ZzOUtq?=
 =?utf-8?B?Q1VHRFdMcFNCV0l4NnVFYnY1Z1NpUjdKcU9UWW03US9jTmZUeUpjK3FtVGlr?=
 =?utf-8?B?SUxIazJ2VnFpOWlhQzNJWkZ4bnI0UGZRdGxlVkJEZVVRaEIrZVc1b3BmV1U1?=
 =?utf-8?B?Zzk0eUx3UzM3VXhjUWFmQ2w4OVlaZ0k2UVk5WXlzQml5RDJEdTNGTTFnRVpW?=
 =?utf-8?B?SC8zOS9iUG9PWENJUU1oVmNoczFPU29sYkdNeFBmWVVZVU1pc3lWVVF2UDFL?=
 =?utf-8?B?MVFWYVBDbGpOOUJBNmlxMklMNHI5QnhSNGRlWUVsaks1R24rVFIyV1dQbnNL?=
 =?utf-8?B?Smg4MVA0SVBhQ1pvR2VGVGlTdzNMRzI1eHo3UFNCeERtVytDSU56V1d3R3F4?=
 =?utf-8?B?dUpiTDVvV0h3Sys5azNQa08yaXFSdU5ibndNd1dVd3RtNEw1cnF4bG40c3Aw?=
 =?utf-8?B?SlAvQkJJa08zMlk3bXNxcTB6VjFTVExhU0dzdVB0N1NiS3kwT3dsYjAwR3Fz?=
 =?utf-8?B?RVpXR251aW1ZdHFNR1RGS0F4R3NkTzkxelZLdkNXSUhIWHhQN3pNemlKWmpo?=
 =?utf-8?B?cnRtU0FIdm1UMDlLV1ZTdkwzekd3VWtjdlhSOXFTZHRTeXNoajNibEVTSHNH?=
 =?utf-8?B?eW5JNUxYYjN0aHNWT3J2ZWp1cHFXSUcvQzVheVZ1emk1Unp1QkVmTzN1cEx1?=
 =?utf-8?B?TStLN3J4dnhPUjZSanNhS1pMNzE0dlFBczJwYWZnaDl2UmVIMzRHOEdwdkhx?=
 =?utf-8?B?bjVSRy9RdUFmWlVGQjB1eER5cG1LTEZzc0M0cFA5VXZ6RTdNSlV5Smxvampx?=
 =?utf-8?B?OE9yTnRsYjd3RFhvQW9qK1h2RzRLOFdIK3pmZDBvSmpaNlE0QnJZVHBZWHNj?=
 =?utf-8?B?R0dIOStESk1xYjJmNHd5Q0lpWE9NSXViaWVEMHRTTUVWdGNtSWNXcEtMWG5y?=
 =?utf-8?B?M1VwQVRJMXMwUTZHbkVXNGwyZHgxa3I5aWxOVTRvQk5QN1M2Zi95MVArRFlD?=
 =?utf-8?B?WEh4ejJKOE9nSjlrRk9pU0M0Q2UzZi9xQlduZ0x5RDREOVk0SVhUMUJ3VENJ?=
 =?utf-8?B?cExpcVNWdnQyT3c3cU1yL2JLNE5uOU5EaCtMT0Ftek1DZG03QTdtV0svcCtE?=
 =?utf-8?B?c2RFQmRzdnphUHcyQiswS24wb0FvdmYrUFVoRFEzOW5uQlhZVUN1Nm12Wmxi?=
 =?utf-8?B?VmtmVjVaaXBoQWdrSXpkRUxrQkprbTFnVDZralJETUtKZThTNlJvS3BsYU52?=
 =?utf-8?B?djlPamVtaFhvMEttM3hZR2pDYjBQL3Vrd3dsNi9jUEJ0dU1qbWpxK3ZHRHRG?=
 =?utf-8?Q?RqasCY0+kQk1cB/m/QgvHcokiI+bYsGgoDrRo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWFyeFFWK0RDakR4djM0SGVaWW1Rcjc3TGtTM2JPek1IclRLbkRDbXR6cVg4?=
 =?utf-8?B?QTlBdG1DaWlHdzNTKzNOMVFNejVuZmhlRDYwRXdpMkoyNWtHalJmYjA5d0VE?=
 =?utf-8?B?aGkrdDFtZ3FMY1FVS0s2Nk5BWmdoQ01HNkR3bkJMczNvSFVTUEJyMTFRQStW?=
 =?utf-8?B?M1VPeEp2ekRPZ3g2andSRnliZTQ3eFp2M3lVcGkzZXovd0VNa0JRZmFFdUEv?=
 =?utf-8?B?VGtJRzVPUkp5YjFRZUJZcG9odDFmUlk3SlNUbWx1TDJpY1NHTjhJQW8wdzNY?=
 =?utf-8?B?Y3dtelZvaUtLZ0FJckdXck1IQTlJYUpVSHJRQ1VaRVU3N0dSSVh6TXRNN0pv?=
 =?utf-8?B?TkhoVUFtV3ZYS1lPbm9CcnovUzBtenk0bWcxTVI3SGFmTDl5TjBhdlVacVhm?=
 =?utf-8?B?VFdabzVGbTdPdDg5YzBkeW5iZ0VSL3BkRm8xY0tta1Rod0lZTnlPbVArL3BX?=
 =?utf-8?B?c2NMM1lyQitHRVUyRlRXMmt0UEI4RXptQWpjZWNZV09wMyt0TUk3aXVqZEt6?=
 =?utf-8?B?RUU0YWUrVlkvTWR1QnZQbG9xdCtUdCt1cEpsYWQ3aU1JNGJnSHByNW1GQVZi?=
 =?utf-8?B?UjJ5Tld1UXVKYmEyQzhXMUZ0bk13d3pHR3hqcEhTTjFSR3VhNkNldTlUay8v?=
 =?utf-8?B?b0sxK1VmSTB3b0dqTU04SU1nOXRPbThjSG1sOW9ibmZ6MGJJbG1MenBhT2g1?=
 =?utf-8?B?UjI5UzRWOVZPK2pST0JQcEhHakhJWXIvekdTT3JoVHpuUlZmaGVKMHdsRGpj?=
 =?utf-8?B?Nnh3dUlWelF4c2w2RnBaWkxvWDI3bDhXdFdTMWdadENLOFdmd2V6Tk91Y1Zm?=
 =?utf-8?B?VU5xdnBYQUExSTdJYlh5d2tuME5kMWtESUREYlNrcWdEUlQwYVdRZVloN216?=
 =?utf-8?B?MjdLckhvT1Z5SWhjcjgraldGdW9NR283dWplNTZmRERLRy9BMEVHQ1Y4MkV0?=
 =?utf-8?B?WEJ3bHNUVDFtT25XdjFuK0gxNjA5RDVaVXZsblZqSU1jMTU2RXlEamNZRVQ2?=
 =?utf-8?B?YkFlYW9pcnI5OVhWV3NPSWl6NUdBVWlvc0M0TU9Lbmk0RDVQd2pmSExIdWx0?=
 =?utf-8?B?SjdSZUhwT2pUdEwzZUgxSnhHK0hTYS96eUtCcGVMemI2NkhEbzdUOWNXNWhI?=
 =?utf-8?B?a041NnpYMk4raEdMUmN6RHFQVjdaNjBDVFR4cmR3Q000Tk1LOHdLTVN1SEdP?=
 =?utf-8?B?WDNKaEkxTThWc1hNTW4vM2ZQMSthbmRvZUsybUZEbTZFWHRneGIyUG9wUHZw?=
 =?utf-8?B?VG43NVc1MjZqS2Jxa3AxWW9ya0xvQVNjeEYvK2hIYndHdVh0UWVYbzNmSFZC?=
 =?utf-8?B?d1YvT0RocWx4ajZWdnZ1SzB5UUJSS0xib21zSGJUenUzOThYTmhPQjFTMCtV?=
 =?utf-8?B?RWJBd1puSWkwNlNMaW1xSlFDanJvNnlVa3pPRE9lQThXdThCOUdlRmZqNlk4?=
 =?utf-8?B?OExkSEx0bjAybTh3bmYxaWNzeGs1a1FmUGoxc2FOR21LL05kOGVVaUFqenpO?=
 =?utf-8?B?alhrcmxTaTJFa2FMR1BjYkQyR2ZyTTF0T0IxWHlWZ3YzRnNzUGhCYk1YcE9V?=
 =?utf-8?B?MWFUaEV5aU56NElpS2pQMmdDZGJ3UktNVVRCK3JUYW9tVXk2dlMvODRLMkFN?=
 =?utf-8?B?NGZ3M21tRzlhVTIvcytTSUkwMjFqWUVGTjVhbkdmWGFwS3JiSDhKaUIrV3Bh?=
 =?utf-8?B?YnlLQnZnb3lwOEl4bnJ3TjVyVzdCSVg2cDFCWlZMdWtTUmoyR3lheDJ0VlBl?=
 =?utf-8?B?cEU4eG9ZTGUzMk50dkkvTWFQRllrTmdPSTd6TlZ4bmJ5aHBaa2lSeVo1NkxI?=
 =?utf-8?B?djE2T0NGNEIrNURXK0dOMlNYZXhHZW5jeE5ibVB4VTQySUptandLNFhlTnN0?=
 =?utf-8?B?Q0pEZlFaSVdlTkFLWG5hbzk1MGNONGpjYnljRkV2aFBzdDh6YUVoNjlpSHRx?=
 =?utf-8?B?QmFJU1pacEs0dnlKSHJqbHlJV0t0LzdWRzJnbGgvZkRyU3FoRDlsbktBVmRY?=
 =?utf-8?B?TklWNGdWMmUyUjhjQWV6WFB2OVAvcFBwanZab09MZWl3RE40VmEzT2NYRkI3?=
 =?utf-8?B?WGlkY0x2blR4dk9uajhmdkdTMTZrdGRWdlRtRlVIVWFtV2txNHJRaUt0b09M?=
 =?utf-8?Q?MJs4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5HApB7ur8HjIavjrFbo6LJQq4bV6OA1+U9/AmiHHxQIAKBE9KOpZXvvj0aiaADgonCn/l9lNivTLmAPSVEMevplOdBeeNIzLHBVpM1QRIsqu584pfpYEDAoGkqczkfCOEA5OlM0b4sPAO5Kdbb0tr/Ip/dn4oB+/XflUfWj0Lsg0is0TB6opvlp8MwD8e+sfylQyEoMuQE6Vn5DNO6raMRr3ySknO8CyZn5AijltAe6eEkGaFl2vaErSuJC6XbCbmmeg7aNxenKO9oMVRyByXwQPxoOzfQLHwnIF0aaaTsq4EyfoWTlxD2vSBxeWs6usRUnTACH1kWY03uONByQyMD7mbf0prIUGvJEVf+2jDlPXjyItRqKRT4j7FDgqjHkBgITIsbbSw4dYUv4YRKpgpYx8FqpJxbGulZY/hmXaxjHnPG9Sv8m68355SDYmyFYI+ffHuXHuxHuJdCOZtYoepxVxnTFqP+svB6+PlhK3Tr9ZF37SILaaZEQncWjhxubK/Gd4/tiK5ib9QF2ZN1P9YCXxmiqobkNZZwUCZ1ZLRA9ykSAEBTHzlDBSYl5W+MgfVuvX0jpzL7HDIO4Y6Sz3zf9dwloUWnw36ZApCgimcfKWGCKd11kaBCRTOe/IFGoL
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889a84ef-833a-43e5-5479-08dd0f187d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 19:20:01.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHjUHosDTX6bxDSwLuCiJVA5fKva9VQV8dU/bA+ZsVcxReW6JU5txpzFnSfT+ur9Bwl2dZGnqkwQNJV4fnrsYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6671
X-Proofpoint-ORIG-GUID: BuLfWqDLeMdjU_1ZCvyu-tGhr7ixgEp2
X-Proofpoint-GUID: BuLfWqDLeMdjU_1ZCvyu-tGhr7ixgEp2
X-Sony-Outbound-GUID: BuLfWqDLeMdjU_1ZCvyu-tGhr7ixgEp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_10,2024-11-27_01,2024-11-22_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gSGkgVGltLA0KPiANCj4gT24gVGh1LCBOb3Yg
NywgMjAyNCBhdCAyOjI24oCvQU0gQmlyZCwgVGltIDxUaW0uQmlyZEBzb255LmNvbT4gd3JvdGU6
DQo+ID4gSSdtIHdyaXRpbmcgdG8gaW50cm9kdWNlIGEgdG9vbCB0aGF0IEknZCBsaWtlIHBlb3Bs
ZSB0byBydW4sIHRvIGdhdGhlciBib290LXRpbWUgZGF0YSBvbg0KPiA+IHRoZWlyIHN5c3RlbXMu
ICBJJ2QgbGlrZSB0byBjb2xsZWN0IGJvb3QtdGltZSBkYXRhIGZyb20gYSBsb3Qgb2YgZGlmZmVy
ZW50IHN5c3RlbXMuDQo+IA0KPiBbLi4uXQ0KPiANCj4gVGhhbmsgeW91IQ0KPiANCj4gPiAtLS0t
IHNjcmlwdCBncmFiLWJvb3QtZGF0YS5zaCBmb2xsb3dzIC0tLS0NCj4gPiAjIS9iaW4vc2gNCj4g
PiAjIGdyYWItYm9vdC1kYXRhLnNoDQo+IA0KPiBJdCdzIGFsd2F5cyBhIGdvb2QgaWRlYSB0byBy
dW4gc2hlbGxjaGVjayBvbiBhbnkgc2NyaXB0IHlvdSB3cml0ZS4NCg0KVGhhbmtzLiAgSSB3ZW50
IHRocm91Z2ggdGhlIGlzc3VlcyByZXBvcnRlZCBieSBzaGVsbGNoZWNrIGFuZCBhZGp1c3RlZA0K
YSBmZXcgdGhpbmdzLg0KDQpUaGUgdG9vbCBjdXJyZW50bHkgbGl2ZXMgYXQ6IGh0dHBzOi8vYmly
ZGNsb3VkLm9yZy9ib290LXRpbWUvQm9vdC10aW1lX1Rvb2xzDQpidXQgSSBhbnRpY2lwYXRlIGNy
ZWF0aW5nLCBzb29uLCBhIGdpdGh1YiByZXBvIGZvciB0aGlzIGFuZCBvdGhlciB0b29scywgYW5k
IHBvc3NpYmx5DQpub24tdXBzdHJlYW1hYmxlIChvciBvbi10aGVpci13YXktdG8tdXBzdHJlYW0p
IHBhdGNoZXMuDQogLS0gVGltDQo=

