Return-Path: <linux-kernel+bounces-401788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A29C1F34
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E5CB21E2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454691F428F;
	Fri,  8 Nov 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="Cjn7xzXo"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5346D1E0B66;
	Fri,  8 Nov 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076116; cv=fail; b=APNxDgcevqJqdmtRyoQCWIZp86FhY4D3a44fN2x/y4LVh4Emy7PGjYpf6cdwbGGydCcYfVCValICXAJMKHsF5938ScCqOxiwv5cZeJ+lwSlGZXl0iYHednKd6GdvLzqakZ9UGfM/GGQP3c4HQhnWxYc9kWyinpSoOTa5MILK+IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076116; c=relaxed/simple;
	bh=Yfj7tAoZ/73zFxfHTxBtW3rLy8RUBr+qlGP39/7wbdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fkwPMQydcvh2qYSAizMpr0dCOyJb3ZUPVsPQYxfzPCkT7zz1dKejwsPmpRu2P4+2e+vWeDkSScdgALgK3uOu6EA9fhxHI/6Z+gVhlWjAfQjhoTKFiXes9A/TtDOoSmuMbO5dbc7oLzSj/jAX3EB99yW9U98CkeyTvTnqyDt6iBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=Cjn7xzXo; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8E9TmQ010200;
	Fri, 8 Nov 2024 14:18:44 GMT
Received: from ma0pr01cu012.outbound.protection.outlook.com (mail-southindiaazlp17011026.outbound.protection.outlook.com [40.93.131.26])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42s6f0g9ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 14:18:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orN8a30h3AoyQ9OojjpuD2Ffu1jkod2tDbnZpTSjcQbSIwKkppa9g/uVQeBhfpmxKLtCWpd8if8tGiyatHly5stTUFyF/34IMVYme3TFoPeKyFPxFUIxO4rfsik8kIJSgj67JHobgar2A+7dQoe4LoSgqv3Y/0vq74oL0VK4aYS3J+wLzwFINg8mIMzmXyDFXufJBRHpqV4xhXEWFlO5Prd636aKBB1ukynKvutzKHFVWq9J8y2/DIuQ555KcOpk9X1EWP5a/zRnFrA/XDmMt2kaHUuN40G8BeEHd9vFsNwntuXsFP8/zUWpcgcGidHX9ur9HaF6yy9l1DRCxkfE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfj7tAoZ/73zFxfHTxBtW3rLy8RUBr+qlGP39/7wbdI=;
 b=g41V7p3QRgVo46xbyhF6tVc55RnQTD00hP0B4K9thbzlrKmzeE93xGvJLD+pcgoJWHsdcmUSDupzL8DT0Vt5qeAyeOgs3kTg8FhUBPUyVSWIvQ5rVPiBw7ZB56aTXs4RUlGE4saqIxyod1r0FW22CboPf7MDweZjAN4Y2d5XFdfJbV7d5XFxQSMBJuERTrFr/EOckQ1spQhMlfAfKGtWcWvYdPZK0V3ExXcUYGCBRSwhbOccauJ2S6lp+gl7WRdab61HbjvhUBPil7Oz1QJl28iGm2nrAa0yrXyYNnMi/VKwuwEfE8XONijCwEtHJP6i/iYzJQblWwM+iyb8mh6g1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfj7tAoZ/73zFxfHTxBtW3rLy8RUBr+qlGP39/7wbdI=;
 b=Cjn7xzXoQQn8Z/1bG8hW2qdk2sYSbkaV7t7LSN9Sjh2d2czSwq2zLeCAKBdSgIsWjQO7ho/f+7D5EZ5kg7XRxgZuH8vAxm7mqtrcmJo9NL9TAT0f1qwlWaoQfzh/BbKJR7ThDxOjqFMEbOGSp8qh3bCWf8js/e9kO6+GO83Uurk=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB7624.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 14:18:38 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 14:18:37 +0000
Message-ID: <0c20e9a2-4ab3-47b0-88cd-a68f7d5c6515@blaize.com>
Date: Fri, 8 Nov 2024 14:18:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: Add Blaize vendor prefix
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
        "nm@ti.com" <nm@ti.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
 <20241108103120.9955-2-nikolaos.pasaloukos@blaize.com>
 <c2438649-eddd-4a35-b50f-3faa065615c3@linaro.org>
Content-Language: en-US
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <c2438649-eddd-4a35-b50f-3faa065615c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0338.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::14) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|PN0PR01MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c746acd-6e21-41a9-8b3b-08dd00003c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1Nla3pGTVB5dW1TV01JakQwNnBwcEFxVnY4eXBJenN5SEt4RGY4U0hZbWpj?=
 =?utf-8?B?YXZDMXJCSi9JVjh6UGdpcWZldkZTZGpqWUY2L3o2N1o5b2M2S1VsSkVJa0xy?=
 =?utf-8?B?LzNwMEVXVEtqTXRzeGFYM3NydFlxK2hjTGczY1ZNVHkxcVFDbCtOaFIxNmFp?=
 =?utf-8?B?ZEwvMDlxYXBqVjRhUzVXckthNy8xdTRiRDAweXRMUkwxTHN6TXQrT0ljNWF1?=
 =?utf-8?B?Z1poMlVxL1NaVitXOG9uV1gzRGhjdFBYM1Y0aUJrNkhzTys3VnE0Zmc5cENF?=
 =?utf-8?B?djlwVVhTK25TbnJ4NXRZTmsvQ1NpY0YyK3Zrd2JUb3JJNE1KYVRYbVNwclIy?=
 =?utf-8?B?Z2VQYmpGUkFYRTc2Ni93bDlveHJwMXBmbXBzbENqb0RQb3hkdDdTbDhyUEtY?=
 =?utf-8?B?NHJtOGdjdTM3MTNXVmI3QWsrUkNYbUN5QTV6dFhGQjk1UEYwTEMzZmtvcmlu?=
 =?utf-8?B?QXpuL21tMkYyUGRDV0JmTlkzSnJvK243cm9CWTNPN011bmJEcVhCMEFJMkNt?=
 =?utf-8?B?WTlUN0U0MnZjQ0JGVFpZdHFOc0dJdkdoeXNlMVp0d0JyWDFHWUlUZUpQODgy?=
 =?utf-8?B?STNYL3dkem16RS9aTm5IeEowZFRNYVdlbmc4c09IZ3NpNk5iQ3MwakU4eVda?=
 =?utf-8?B?NzQ2RHhwY0tuQnRPSGNxRmtTOEVPUDB4T0g3WVYrTDB2aXg3cWQ0dlRYSGZM?=
 =?utf-8?B?OE1ZblQxVmw0SFFIb0R3em5wdCtHdTg5Mi9mT2wyMkpSbG5rRStPUmdKV0Zp?=
 =?utf-8?B?dEtsZDZFeUk2eW5rR25SdTNuT3BzTzAxeHFWSU8rSjZoaUFEaDVSYUFURGF4?=
 =?utf-8?B?WHdwQnlaYVBMR05PVWpVMjhDUkdtUXRLQjRHamRHN0xpQUdoSzFiVnJIcU9Z?=
 =?utf-8?B?WjNES0pZamgwZUVrdmlIc1lHNGxtWkxIcVlkcVB0TFNDL1FscXNjWGRtQkEr?=
 =?utf-8?B?Umh5ZitFS1pqTHpDcWJ1YmtyRU0vbHRUaE5ySUl0aVFCNWk1azRMWjhGSURE?=
 =?utf-8?B?L0N0OThvVWFOY0N4NHhuMU5WSGd0bGlYMmlMd0V5M09zK1Z2TDA0SzhYek41?=
 =?utf-8?B?ZW4xcVlPSFBaSjBzcUlDM3NYR2dpWHBucGlESzh6YVkxUHNDaWZsVVhTTGQ0?=
 =?utf-8?B?RnM5cURZWUttRzNPZDVCK2NsdUdqM01rcTJUeVgwYmF2eHBaTFp3N0lOWDdz?=
 =?utf-8?B?a2ZjMzcyaVBBcjJSUXJOWVpBS3k3RTZVNnlrem9vRDJFQUVoeDdLWmJucEND?=
 =?utf-8?B?ajFUSTlGcTFPbWJ4MFpPSmhFVXZ6bGtCaWFsSEh0UjlCUGRwY0YxYkk2M3Fn?=
 =?utf-8?B?VXhjYkd1SWN1cU5RaDdPc2VGQWhXbTUxQ0t1bEVzNzJrL3AzOEx2Q2gvSlpR?=
 =?utf-8?B?MS9FbnVzTWVPdHV1U1AxMU5IVW1rZmJvZHI1MkdlQjVsQ0ZSbGloTW1KNmN6?=
 =?utf-8?B?SDk1R3pYcmJkbjBBUnJ2N3JtSTNJKzBYc2hxa2ljY0kxb1BXV0F6NlpoSlNt?=
 =?utf-8?B?aDZkS1pBV2IxREVsdnNnRmVRNlc4WU9WNzRHaVVWb25nSWMwaE1haFltaXdk?=
 =?utf-8?B?NkRxWHNZZmtlUC9aUDNwbU9xeG1YNk93Z3lFRmtNdmV4dXh0eDdKSXc3SjJZ?=
 =?utf-8?B?K0gyOTNPczZiTjFlVnEwUkQzcTN3cy9LQXNBVmhzUFV2ZkRpOWs3eDJCY1N6?=
 =?utf-8?B?dGFYL0UzTTBreVJSaE50UFpCWXNYVUZhcWl0UnJiMVYrVWF2Zmd1ZXhRdith?=
 =?utf-8?Q?tRWZrlY+jga1Udk6SQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUhvNG5XVmV5dmNHcE0wbVYxc01sN3BKTWVtZHdWM2V6eGhENFJURVdNQ1ZZ?=
 =?utf-8?B?dkxJcjdLd21aZTRtTTJ1bG1DR1VUYXorVzZiQytoU2RZUGNseEN5S1hsQmRN?=
 =?utf-8?B?SUNrY04xTG9OQ2hVSkl0dGhZenBMRzlRSjZRRmVRMUthL0tBNXZCeTY5UGR6?=
 =?utf-8?B?djVEd0NHZXFPa0JPN2VMc3JLSTNMQ3NjRGdsakllcTRjWCs0QUdjbFk4cnZD?=
 =?utf-8?B?NHhOejU2ZWt2YnM0NnlQRmtKWXpZL0FGNnNNYitzUUpMU1VoY3VnaVBNZGVq?=
 =?utf-8?B?dkpMSkVOY1Q5R0dSSmhvMlllbHVkVzJhTktHbVQ4WE9hb3hUeFBCN2wxNzN3?=
 =?utf-8?B?RWtra0NadURTWnllUEhUd2lXREE3VGdwc0x6Ujg0WkJyQ052dHJvRXkzTjdz?=
 =?utf-8?B?NTdIK09kYWFBTW5mb21Sa3FnejJrYmtNK1hZclZBdDhncks2aGMwdXBIaDBs?=
 =?utf-8?B?WmJDTGRxYXFoVnU5VFZ5NVEzUlFhclJXakVWcnNSM1VGREl5YWhmOXlSYVNz?=
 =?utf-8?B?Z3BmUWtKL0I2Qjc0RTNWTm5XZ0lFd0ljanpCRzkzZzdzY25mQ2RHbmhwTDJO?=
 =?utf-8?B?MVphUll5SE5PT3EwMnFOY1lLWFBHMEtta29MVGE1UjVKK0RhMmZDY2VtelRy?=
 =?utf-8?B?YUtIQlBtQkVhd0JXT0Z3MFR2RDBDVHVUUFRxZHQxTUdVYjFKakVTcHh2K2Rr?=
 =?utf-8?B?eVFwY2tBRDR5bExOcUxvV0d2RU5RQnJFaDUzS3ZNS2FRYzliaGtFVTFSSk90?=
 =?utf-8?B?WjF5czVRRktkdHA4Vlk0cnFpSHA4Wm9SNFk3TjBLOXlzV1BWZkE5UUxPYk05?=
 =?utf-8?B?SkY1dDdWbkFRTWZmSkM4cDJKNlkxVlpZZldaaWgzejNJSEVra3QrZDhoUWt1?=
 =?utf-8?B?bDN1NTk4TS82UnRqelptanRjMWg2bXZJUktoOTRNaFlGdllWRm5vbGhWYW5S?=
 =?utf-8?B?dTdXdytTZWgyTDFGVlBHVGFVcUxDTDJwRnlKQ3VySUp1UWxoNkdFbC8ySEIv?=
 =?utf-8?B?QWc2cEE0eFJDMkZwa3Y4NVpDZ0VhaXVrTG14WnpsQnVhbG5rYW9lSnpPZ2di?=
 =?utf-8?B?R3pNdmZtRi94aFR3RThvZUJvMjVhMDZwZzBRQjlYZ2hTaTN1NG9zMS9jSjNR?=
 =?utf-8?B?R094djBVQ1VIZllFeHpBZ1pIUGIvdGo4Uk5ReE02b1VDMFN1dzRuekRoNkli?=
 =?utf-8?B?Ym5YWlFLYVFtcDBiSHhtUHZQRGkvcDh3U1FSVnRaWlFuOWhtb05EZjF0blR5?=
 =?utf-8?B?S0JMWnNOeDMyRHFFWWZHc3BuSlpVZUE0TCtSVEd4V2ZwVFBVZUdCY0R4czJX?=
 =?utf-8?B?SDgzOXYyS0hRc0FsRUxaUTY0NUhJTS9kRE0wYkVNZ3ZHTmlDM3RHN2l2NkJj?=
 =?utf-8?B?eWg0RXhGSzNKdmtDd1M3Q3VTTXpWeTFlWERtaFJjU29TaVArNnBWOHFDejFr?=
 =?utf-8?B?MVN3NkZzZ0VyVnNLV3N3OEtMSU9hT2t1TitTSkNNSURGd2UzYlhMTkt6S0Np?=
 =?utf-8?B?OXRDLzlxZVNPQXgxU0pNelpYa2lLZFJzNmI3WERvQjVnR2cvMi8yVU9jeXFS?=
 =?utf-8?B?OTgxZm92SWh5bjRNSXdDOWVkMk9FZkNKbklHZ2Ftc1hCclZsYXFxcXJ1NDRq?=
 =?utf-8?B?dXN4YjVkY1hFelZTby9LYlB4YzVUUjVJYzZFM2xveUNkaHNLc2hienlLZXFv?=
 =?utf-8?B?RjFybyt1OElBamNPK29uQnJ6K3ZHNUllbC9ZejREUEFJSVdMZTM3TlQ2cjBr?=
 =?utf-8?B?V2wyRkpyM3NrdkFxeUUyU3VVcEJCNmVjTVo2RlNtR3lQcEt5bTNyUFMrYXNY?=
 =?utf-8?B?UloreFQ3eG4rY1BuTlRxWERRMkRZNS9vU25KelpTK2x1eWE1YlB2eStTWm5F?=
 =?utf-8?B?OHlVcWZTYVRyT1hhSWZKNkFuZlZrY3dkSEVmbTlsZ01mUVhScnYvV0wwSHJ5?=
 =?utf-8?B?Nm5xTUQ0YXJ6ckNrMlNTZFRIQS9LMFdOYXdNdytrOWR4cHRnV3poS0hpU1Rq?=
 =?utf-8?B?ZjVVSTZvM3lQbEVQU2JyS1JZZHJBQkVhdVJCL2pXNzFqWmJEai92SGpPRk5w?=
 =?utf-8?B?RzBsa0phRjhGcHdJN05zeU9pbUdyTGVmM0grTmFJeDBoaEwrT1EwRytjM1dl?=
 =?utf-8?B?UzV4Y0Z3NWVrTW9uaGdQVEdwWnJodUd3Vk5zQTZJV0Q3bEh4UVk1LzdjL25J?=
 =?utf-8?Q?UesX9mJVYKWxXyV4StKk1Hg=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c746acd-6e21-41a9-8b3b-08dd00003c95
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 14:18:37.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS3rE19nFFXbBqVaN+Rvi42i1AZu7MKtDZ+VtxoWWREhvmq/1tdjpIrSfnH66rV23U8cVo2ZTMDTDGDoouFH9c8XR/nY3ODLnM0BtPE0eWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7624
X-Authority-Analysis: v=2.4 cv=JJlpsNKb c=1 sm=1 tr=0 ts=672e1dc4 cx=c_pps a=KVJtB2hM+tsqvTPeBUBRDw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=-efVfFQXF6NVvEpH-LcA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-GUID: 84LddYPKsnQ7HgSpUD0WOyzzcz-XjEz2
X-Proofpoint-ORIG-GUID: 84LddYPKsnQ7HgSpUD0WOyzzcz-XjEz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_11,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

On 08/11/2024 10:54, Krzysztof Kozlowski wrote:
> On 08/11/2024 11:31, Niko Pasaloukos wrote:
>> Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
>> programmable Graph-Streaming-Processors for AI and ML.
>>
>> Resolves: PESW-2604
> What is this? The tag and the meaning? How does it matter for the upstream?

Hi Krzysztof,

First of all, thank you very much for your fast review.
Apologies for not rebasing to the correct branch and having so many people in the list.
Also, adding the --no-git-fallback reduced the list even more. Thank you very much.
Apologies for not deleting the internal tags and causing confusion. V5 will have all these fixed.

Best regards,
Niko

>
> I do not see you using b4 so I do no understand why you Cc stale
> addresses. Standard reply - please fix your process:
>
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument, so you will
> not CC people just because they made one commit years ago). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> </form letter>
>
> Best regards,
> Krzysztof
>

