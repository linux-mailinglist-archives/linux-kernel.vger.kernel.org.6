Return-Path: <linux-kernel+bounces-414320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7B9D263F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EE228167A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770001CC150;
	Tue, 19 Nov 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="cbHhid8S"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264E1384BF;
	Tue, 19 Nov 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021116; cv=fail; b=fBwUooBSnbWOKJdPg7rSxCNPXuAS+K3W7YPCGAxQjZEs8vUo4FIKb/A1DqOyDLLb7mZBRVq8/CJzka+TcFkQwwF3+wkc26dQWJyakomQMHh/Sa5EeMnrNwZMygXW8kIRoPWPqHFoSEU+GDh3QV7SWurYrfnl06m7ynkRiOm+cbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021116; c=relaxed/simple;
	bh=aH/Z2Vy6dbn2+pnC6kH5EvRoC9iyrLYSH/vDZkANh4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMvyYD4pQzoI8ENO4SRDQPu64ODSPe/oUbp/fe+hRGQsn01XgPPahgzXjiXcMdop5bVlJjQw8f3YJKgHy657PUfwrghJ1wC2c8zBrJ6txKsbYterdH1IfKNsj1SoCQKJ7VZ+0KT/dGUehWBhxkn/fQXTK00EzUmdD8qBrx03+gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=cbHhid8S; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJBnvpR012331;
	Tue, 19 Nov 2024 12:47:58 GMT
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010003.outbound.protection.outlook.com [40.93.131.3])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42xhkxh9b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 12:47:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY4PZJBIcHGDEQcXJG2jI4IDlaGj9rUMerKJqBFjjhysnl246t5HVYj/yP+zZNy6qXoGQDRQbErJ4rrg0cATyPXaXmXEjvQ7QiBs6CHIFmQQDpApPx0oukXk/+zllo1sBDksxr2kwWx1od1ICqnIpRtlCN5QYZn2nV9Y9gs4dgoiJlyTT2v0ZAJULTT44FRisd5cW1i4pNi25dp3tpSpqIpSXu61Dc+SBH1PAEQr5N3TJrjf4D3fxZn6fqBoTqzuH1jbNSOl7F3SCk23ofUU8Rg8WrCUtOgFFhIzqct8TcZZJCWUuDmn9VYpXkOH+lfoZEeBOlWI4/yCLQ+es127JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjpRayvJlHjyXJ7KO97gkaSrz6uuwYAJ2wiJyJBgnmo=;
 b=Ct1pbDQnzLbECi8tn/YBHuog3ejCNs7sa0horq7GtudTllgfbvjS2cWpbCEgOKDAIsM5Sjz4kQudX+2HsM6wHLGm9E7G9GckXQELtb7J4ppYotc6nrMUSoHKkOy5rmBfbmhWrHrbEpfoIzYoAmz1Yu+4yj0uYIijY0ko6EtDa7ocTKUlzBsf9oJp5i17iO8S6siUtjHLuXHwxN91xPzoLYmxwC73xvYfCbBIYuX6RiPVv9PR8zcNcS5LKwZP0KRG388Rh2fphYjXRXAz/eKLyHDy/3IiQrhm8hUYeHBQkqJmTqXdqIxRM3Kv2JVsNVFIqXFYl5CKBPpZEKVMf9Li4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjpRayvJlHjyXJ7KO97gkaSrz6uuwYAJ2wiJyJBgnmo=;
 b=cbHhid8SZMyjpxl/pgQDmF2JOXhpE44GlPkVitErRL/wnlMNENVFbakQezPTJ5wdgMXhQsJ43I4Ih6wSVdEnt6X6aRq86Zue6unaM13aWUUiAW42CszGpd7x/BDJJ2LxEBW8Zo0SyLHpQY13zVKIXiqDTzCd5mRhBlIzhP76Jjs=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PNXPR01MB7204.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 12:47:50 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 12:47:50 +0000
Message-ID: <0c3063f2-1a5d-4ada-a813-7e18a681510e@blaize.com>
Date: Tue, 19 Nov 2024 12:47:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] Add support for Blaize BLZP1600 SoC
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "soc@lists.linux.dev" <soc@lists.linux.dev>
References: <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
 <141c7d39-9f0e-4c1c-86c5-149328ab979a@app.fastmail.com>
Content-Language: en-US
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <141c7d39-9f0e-4c1c-86c5-149328ab979a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0330.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::30) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|PNXPR01MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccb93ee-361a-44cb-92bb-08dd08986077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk5jOGhWNHA0b2Q1UFZES3VaWWw5UjlscVUzbDFlU3BKUEJJNG1rRllkTGdW?=
 =?utf-8?B?WFQ3N29HdWphT3hSakswZHV2cWQ3b2VDVitRWU9qNkRsS0pjZGk4azhieVhj?=
 =?utf-8?B?cXRkRGlWS3lFSzJvTm81NlN5a3Myd3ZxREpFdmwreENsS2FHbzFXNXJ3MjZI?=
 =?utf-8?B?TnR2bzB5WjAwMG56K0tibHBWSllXUWc5RWRlVWl1Q3hibFhORkFrcDJQSXVp?=
 =?utf-8?B?Slp4Uk1zL2dNZFFPMXlKaU1aQ1QvRTR4VStNT0ordURTMFlqVWJnMHFKOTBB?=
 =?utf-8?B?VmxnVm9JNHcva09FNGxSd25JQUZ4WmJtTXp4Z1RBdjZSa2ZOc3FDSGdMWm1z?=
 =?utf-8?B?Y3V6VHRZelp4V3pwUDU2Z3l2Tk1wcXo3a25BaUkydjFnUW4zRVdNTVpmVlZC?=
 =?utf-8?B?STNvcjNBUkx0V1V6TWZPcUxxQ2JES2VNckFqcHlxTWJqS2VmQnFJR0xZcTdK?=
 =?utf-8?B?eXlqR0l0N3JKalU3Y1FHNVpBYmlFeWo4UzF6c2tzbWUrcW5jNlo2T1UzaEdH?=
 =?utf-8?B?NE1QMjNGUGlsckYzWmw4Wi9pK0xUNnp2cmlaZDVIUjRLdGZHTzNZdXhzNm9P?=
 =?utf-8?B?cWZnS3BTZkJlVDd3NVl5dXJOMWsyVHlwTU4yM0FLdlhPaEEyMkxCWDI5bnlR?=
 =?utf-8?B?Q3M5UTg3bDR4bjcxZHZ1OUg3VVBPUmJySDRnK3lvb09NSUhUek41a1MyNzRh?=
 =?utf-8?B?NlRSSzUvVUZuUmRZMDJub1VnVUI0dHh1dXU4ZXZad0RZQ1Y1ZHJKcnVqQm9j?=
 =?utf-8?B?MitvK2NzZHo0OWI2UFNrRjlWNVpQREQvR1NMeGVMbVd3Wll2eHNLVjkyOTN5?=
 =?utf-8?B?aHVPL3EzOWw1TlFaOFVCQ0xsbExQTHRwWWNIZlJ1WTI3VC82WWZNVFlSOSsr?=
 =?utf-8?B?VSt5dmxQZWQzc2FDUHNRYTBRdTBNZWVSeXBCUkh2Y3BkbUlKWXdaUE5Hblg3?=
 =?utf-8?B?cEtnQ3k1Z1pFZWFCeWtKblF4ZGU4SHY4a0JiRzFQekR3Wmw3OVdzZXB1SmVB?=
 =?utf-8?B?aklSY2ZEODdRSnZYcVdJSnM2NU1kZkZxdUdod2pMSXpPT0FnbmNhRVUrMWJO?=
 =?utf-8?B?b2REMVFCNW1SLzR4WkJpeWdBUzFXc0t1N0d0SjlacGZTSnVxbW9zQkp3WnhT?=
 =?utf-8?B?WFNlZkplVk1rRnFKWGI1RmlxZkhsQ3VDNjh3aHFkNTRleHRURU0yVnE3NE96?=
 =?utf-8?B?UEw5YTVvMDhVVVZrcHhONFlNNm41TGtoT2ZVb3JmT3FhUHNvL25QbWFQeXN6?=
 =?utf-8?B?bWZPeTh2b2hPWElnS3k1YXRLNnNlaS9rVlBIWC80ZHoxS05JRWc1VDJFZGN4?=
 =?utf-8?B?WVdKTG5CN3I4TFBwTnRzNGxOd2dnZU5zV3dUZ0pIY1ZFdUNjdGxONThaU29r?=
 =?utf-8?B?ZUdiczFpUzBsQ3JRTEtZNFZicG9PZDA1dVlFZkVqS3ZWb3ZOUUsxeVNka0Fz?=
 =?utf-8?B?ZjhNd3dJRjNYNVFhVFR2MHRFZWswWWxtcnRoU1hiZzE0ZnViUzF2K0Z4SkNa?=
 =?utf-8?B?enY0TDBMdnhQY0VFSVgyY0Y1MEg4ZEduUUlvY21xNEF1SWZhMTVwZStSSmph?=
 =?utf-8?B?ZU1VV0NHY0dSeG05aHJjYk1ESjBheDJhcEgvaUo5c1V0K1djWk1GOWF2UTJX?=
 =?utf-8?B?TVZ0ZC8wbmhJZmFVNkxJbU12OUx3QjFLUDlJVjVjTEhVMHd5WDhzMERiTzl5?=
 =?utf-8?B?Y3dueHRUT0MzbjFpb3NhRSt3QTBudTBRRm04VDFhYzVxQy9EVzVjZnhMVUdH?=
 =?utf-8?Q?L/3ksybSvp2rFxkjOA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkN4M3BBcEVpdkU4emZwVEh6K0Q2bGwyVTROZlIyZ25BUDZlV0RNKzQ1a0Za?=
 =?utf-8?B?NzY3VWVkVFA5MlZreW0ydmJwbUVWRUxKdWRHZFNKMmZ1MzZHNW80VGFrZmVr?=
 =?utf-8?B?S29VR2dqb01BZzVDdkYwcm5ycnNtbHAza0QxK0F4N01iWW9yL2EzTFlXZmtI?=
 =?utf-8?B?ZGVoRHZTbGpiQnpJZ3R6eEViTHludm9HZUxpUFdNQ2N2Z2RrQ0lENm9GUWJj?=
 =?utf-8?B?dFdGb3BmbjVQM3l0bEdVMGRxSWR5QzhxT3F6c0U5QU94VjVObVo3US9na2xl?=
 =?utf-8?B?MjN5TzlraXd2b1ZWSFE2b3JwTTY3bitoczZXZ1Fab3E1d1E4UHRYR2tBMGpJ?=
 =?utf-8?B?VFJkck92bnVqTnlQVGJET1V5TWVLN2pRYmlwR0JiWGg3UmlzWGVLM1VEOW1T?=
 =?utf-8?B?VXZjdTJhV1R1QnZweUtYMEFUamJ2ZFN5UVlsSUMyTlJuajlNMWRPeUVGbndF?=
 =?utf-8?B?aWFvOENDZUM3NVNqcEF6ZEZWR0I3c0kzVytKS09EODhremlhOFJrKzR3VkJj?=
 =?utf-8?B?TWJ4c2hrOHZQM3hZZ1FLME5JNGZpTDFmMzVTcXFJMGU0YWhsaDc4akpXdUZD?=
 =?utf-8?B?NnY4Y0ZvRlVMWlN0OWk4cGtjazF1VFkvQkVpUkNQQm1VNjZYa3VUUlU1NG4x?=
 =?utf-8?B?SW4xeENJdFF2dGVtUjdodzhRRzR3SnExNzRrNEdhcHppbmRBbHhld2IvS0E0?=
 =?utf-8?B?ZWFycHBYZC9scGdsbzFBVDN2ZXppeVlZbFcyeVRVL2ZvQVhhejBvalhzbUdn?=
 =?utf-8?B?OXNuSFN0a2l5eFBGbXlsL3ZzNDdkOUxqR0Y2NDlibjZCZHU0aElEdE51YThn?=
 =?utf-8?B?ZUUxSXZqc2E1Rk9tenF4UU9yQjRaNFB6SWFnZEIybDY0REh6Mlc1dStUYTM0?=
 =?utf-8?B?ZUFEUkwzdndHbzFES05OV1REM0hnUEFzeU9ZYUVVeEdGa2RMRnlKeDNQcWls?=
 =?utf-8?B?NU1oaHlVUkZYbzlYV3N2dTZDMk5vYzN2RUNUV1BJNnVwRCt1ZjFDZFBzQXV4?=
 =?utf-8?B?b3VabUdzb0cwWmxySm9mQzBIUkYxVDV2U3RuSXRyY0Ewc2d6dnZnUkQxTm1N?=
 =?utf-8?B?ZklQNHpJTXMvMmZtR3BmbnpQdVNPYTY1OENnbUpPdTgvRU0zSzRCUGVQSTlS?=
 =?utf-8?B?cEF3YUNzTnhhSG5KamF5UTM3L1A4ckcyaFBtY2NqWjlpbDRKd2pOZkluaU1w?=
 =?utf-8?B?RjFUVHZJeEVLd09vMUtZZDQzdkhVRGtJbDVGcnpVL240OW4vSmYxQS9IWUh5?=
 =?utf-8?B?Qzd5WG5qTTRMQjhyQy9sakd3RXFWbGtONnNmQXpFQjJNeGd5a1RjR3ZVZDQx?=
 =?utf-8?B?ekZscE1xUE9Sa0Z2QXh3d1ozcE9kSUdySHJNOHVXd2JzSFhsbjJLbExJNDdY?=
 =?utf-8?B?WnN6cmVLLzd0MHppM053b3FOV0czUEpCWDZVVytwYXBvQk4zaUR4eFBTdjc5?=
 =?utf-8?B?QUlzaXJ0OWlqanVrTkpZSkdOTjh6eTZWaE5HUFV2QlpMUUJWTktnSUVJYmk0?=
 =?utf-8?B?WnVKeElZN2d2cXNlTUJwOVQ0U2xZeHhhc3RVOFNoTWJIUzk2OHRKZFZyaGdH?=
 =?utf-8?B?cjhJdWtTN1ZNeElQNENiSzUzK1lPdWxFeXRpRmVyek1PbFlWWDRsbTZrdG1p?=
 =?utf-8?B?cEdKYmEzdE1IM1BlTVB4QmtOTEpVZXF5YmY5NjZrSDdjTmQ3L1ZwV2VURVFv?=
 =?utf-8?B?VmMrT3FWazlrZUZHejhJcDRtQ0NmQWNiU1k3WmU5ZFBrNnY3Y1pPUHFGOTRy?=
 =?utf-8?B?aUYrcG1vWExORDBuK3ZxM0EwT0NRejJoSDdHUEVQdmtpWUdWODBmQWR4ZnJz?=
 =?utf-8?B?SUU2QjN4dWQwcUs0czZKNldtQ2hvQjlFSy92blJZa25kbDFqQkQyNUNWTjhE?=
 =?utf-8?B?Kzh6R3R1b2NhbFdXS0RmYXlBb042M2FVVDZ1WnFOM2hhSU1WUWdJWVZZdlBK?=
 =?utf-8?B?SDhKc0tKamczSmJMbnpUMER5ZlpFL0c4VzNOUngrSmN3UDU2b1k2MnlFQXFY?=
 =?utf-8?B?QTdjZ0FuMmJXVVFLaUlrRmVobDJYWUdzbThNdlBRVkpQb1FEaldDMjliRTEy?=
 =?utf-8?B?dnI1aHZmVVJueGt4UnJZZFJIZE1EYlo5Yk52Q05JeG1MRldubTNqOThTMy9O?=
 =?utf-8?B?ak1EUXZnK00yazFyVTY1SUIvZnREK2svdW5kQTRMdWdrd3JHb1ZldE1QVlVx?=
 =?utf-8?Q?48V1inhazaK8HERkcWtwJVs=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccb93ee-361a-44cb-92bb-08dd08986077
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:47:50.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDILy1DonaayMfMnMzfO8ASx5BosYuKC9rtqDN8z8yVExAiypueTH9qfn82xRb1ogxvpNU5frnWXJpWhuVuyOMnSJIGObSRgRSBrYvLwH84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7204
X-Authority-Analysis: v=2.4 cv=EPtU0EZC c=1 sm=1 tr=0 ts=673c88fd cx=c_pps a=4gqXieoWB9RDLA/+jw4MSQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=VwQbUJbxAAAA:8 a=FHrv_42d3wVIYeB7chIA:9 a=QEXdDO2ut3YA:10 a=Dzz9xnhHhD8A:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-ORIG-GUID: XLiioK0uUoj05IbEVyogyujf08pysLq8
X-Proofpoint-GUID: XLiioK0uUoj05IbEVyogyujf08pysLq8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_04,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

On 15/11/2024 15:09, Arnd Bergmann wrote:

> On Fri, Nov 15, 2024, at 15:58, Niko Pasaloukos wrote:
>> Blaize, Inc. (http://www.blaize.com) is a SoC designer and manufacturer
>> with integrated programmable Graph-Streaming-Processors for AI
>> and ML. This series adds support for the Blaize BLZP1600 SoC.
>>
>> The SoC can run as either a PCIe based accelerator in a host
>> system, or as a stand alone SoC running Linux on its integrated
>> dual core ARM Cortex A53 cluster.
>>
>> The SoC includes a suite of peripherals, support for which will
>> be added later.
>>
>> This first series is just the basics to get the upstream
>> kernel to boot with a UART console and ARM SCMI based
>> clocks and resets.
>>
> Hi Niko,
>
> This version looks good to me, but it's likely that others
> still have review comments. Either way I should let you know
> of the next steps for merging the series.
>
> Since the 6.13 development cycle is now over (the
> merge window starts once Linus publishes 6.12
> this weekend), the earliest release to merge this
> into is now 6.14.
>
> Once 6.13-rc1 is out and the patch review is complete,
> you can submit the patches for inclusion by sending
> to:soc@lists.linux.dev (formerly soc@kernel.org).
> This is usually done as a pull request, but separate
> patches are fine as well, especially if you don't yet
> have a kernel.org account.
>
> After the entry to the MAINTAINERS file is merged,
> I suggest you also apply for a kernel.org account,
> see [1]. You probably also read the documentation at
> [2] about the usual process, let me know if you
> have questions about that.
>
>         Arnd
>
> [1] https://urldefense.com/v3/__https://korg.docs.kernel.org/accounts.html__;!!FddXBOku!ny-gN1hGaRTxNpi1ADJf_s3xLmuIdAZzGy4uj6kacOw-p3lLhZfSFLF2Mb9UcuIbd1By_ERGVnHqEbEiXhbK1g$
> [2] https://urldefense.com/v3/__https://www.kernel.org/doc/Documentation/process/maintainer-soc.rst__;!!FddXBOku!ny-gN1hGaRTxNpi1ADJf_s3xLmuIdAZzGy4uj6kacOw-p3lLhZfSFLF2Mb9UcuIbd1By_ERGVnHqEbHSKH7PdA$

Hi Arnd,

Thank you very much for the detailed explanation of the merging process and release
cycles.
Also, I would like to thank all the people who help me during the review process
and for their helpful comments.

Best regards,
Niko


