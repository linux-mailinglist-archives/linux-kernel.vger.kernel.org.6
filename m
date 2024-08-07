Return-Path: <linux-kernel+bounces-277279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A27949ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44A91F24F20
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC019066D;
	Wed,  7 Aug 2024 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j8laq9FK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BNrrJPDW"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B723CE;
	Wed,  7 Aug 2024 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723004480; cv=fail; b=TrywWP/I9CXIFwGCY10JsDFHZ1lbKg/Cs5PLGW1Gn/upK5RIJ7rNV/SladclJqKIx+3gXcMJ4nDTniomHUGkvoLmMT2+vxqAQSo+5543u7v4r3Qeg594+lIQmAe77p+Q563v+dc7vOtfyUpSFLhk60ip4e6jgqXMd1DH9MCvJCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723004480; c=relaxed/simple;
	bh=F++ezUOIA+z/O32RrjUdspzfT3/jKpowshqYGrQ4Gr4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fio6bhTvuPeIqDDkiLuw9wsS2YOCxsCXQjixMOkN7RJa7XF75RoSBjvnEUdrP0aEDXkxTdhSqYq/oJ4DqQ5ttzVQ3leXudlO/BY7K9m6owIA6iBOIt6iKFtqvG4KvxSLBNfvP5DCNhru5uXErynnNKOBSDLW7xSKUFmGAgKoGKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=j8laq9FK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BNrrJPDW; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7ac76ec2547411ef87684b57767b52b1-20240807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=F++ezUOIA+z/O32RrjUdspzfT3/jKpowshqYGrQ4Gr4=;
	b=j8laq9FK3x4fRJpQdUywMqH8NuRNoYBtrhr+LlLQzcLI+AYB6NbqYaW2PCjdheEr3bRJl3i+eX0GoIsscmfTBv4CB5UB3LlIT/WlWVDdMcJ5G05MFrq2UocZKivPvs9aMTyyr2B7OsFr6M8DdtOASpESEJy0tSnxqfVjuvWKsgA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:63b608f5-b396-44e7-835a-d2c6c80f4e4a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:8b08d33e-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7ac76ec2547411ef87684b57767b52b1-20240807
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <trevor.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 774017391; Wed, 07 Aug 2024 12:21:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Aug 2024 12:21:12 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Aug 2024 12:21:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irzo6NB/UKc+ROMUeqv0ajBCnZfbs4ZouKsKHRauuOx4TlN7yqUua7fb7pyT4Iss29DVSa22aO4XkYHO7xwi7H1loeEALAZ6O6s0azdGyy4fvCBP2c2RQoyymmY1BdkZynZC9JhHtv11V4K7N8o7nyujbfLME9zKRo7qvNHj/bDXzYl3reZ0bAYn8S0Ut9IP6RCjBUqUyyJvMjQ2nvDX0mHKF7mYT9WPSqH2asA0v2xw4g92cM5IyiV8gWdYoCV+eQ8jbZ6R52ZbHSdve1craJfIx5BcyCPGyV0EZTNgl6zv4fOaVzR7HlANFM3TsQcAEtB36kYEbvffnmnF36c46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F++ezUOIA+z/O32RrjUdspzfT3/jKpowshqYGrQ4Gr4=;
 b=sjwFefvY7PgSD6S4pBJXF3S9FoWU93mfxShwowoqkD+2AfwDX2sV0y6hTjNM0YXNl8L4pdryQYXZGFWvys1yh87C5Zdax0XHav/0m3B+km7XjukNiaP/Pw4Hapvecrdycuf1/4K32F33qqOUjYv2N6uegQlO7+HTyKQ6RvDb5f56hIvDFDDZAyTNVc4OpJ1KJy7TTFckp/n73wwovx3Rp4RVB6lOuOFIWM1ArPsHltQatv52vpuVCz0AYM3IiC3dusljCcwrdGYj/AiUBg/ml06f6mDgPAbmYX41YNWGdNTsPNghJhfZcQLLULoE/Y4ptUtvSJzlGSMVz3DZ4HIhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F++ezUOIA+z/O32RrjUdspzfT3/jKpowshqYGrQ4Gr4=;
 b=BNrrJPDWDAIQroY1ezxozZnSijqAuQa4yVUqOm/D2st0Ua/ainrOowWn7AtosOjU13r/S6tKfRXYKCR1ZIRkH+NmiCuGXBHfUcQnwg4PvUDtvymKHvdkY4flXrW9StPIInwVsVJtTiskKI6QokVzlB1SU+04P3vfI0j+f4uAt0A=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYSPR03MB7308.apcprd03.prod.outlook.com (2603:1096:400:416::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 04:21:10 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 04:21:09 +0000
From: =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	=?utf-8?B?WVIgWWFuZyAo5p2o6JOJKQ==?= <YR.Yang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "perex@perex.cz"
	<perex@perex.cz>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as
 volatile
Thread-Topic: [PATCH v2] ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as
 volatile
Thread-Index: AQHa4+8R2UJigwkMv0OKRL5WODXwELIbOpUA
Date: Wed, 7 Aug 2024 04:21:09 +0000
Message-ID: <e73062ec5d572e6f164ff445b616f2e9662fc0ee.camel@mediatek.com>
References: <20240801084326.1472-1-yr.yang@mediatek.com>
In-Reply-To: <20240801084326.1472-1-yr.yang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYSPR03MB7308:EE_
x-ms-office365-filtering-correlation-id: dd48811b-69bb-4772-b86c-08dcb6985d4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dk5LbDdEOGRFUHJ6QXZsWWt5b29oUFFtdC8weG1SMklBeitmVXpORVNYL2s5?=
 =?utf-8?B?MjhkM2I5OHlLYzMrbzl2Q0NkM1BQL2xPWlY2NU5QMDVFaXRzY3Yvd1Eyem5v?=
 =?utf-8?B?cWlWa2QvdmVDbzM1WGNlQjNJMW1wQk9jbkYyWmVIL1YyOVZXcm4rVUVzZ0NK?=
 =?utf-8?B?cUc4VTAxQlM0Y1NSeDB1dklqZ2JIMUw5TGwwSkkwaC9xdlBOYldwdFhyUnlz?=
 =?utf-8?B?S3dWUXUvRW9KK3VhcENwTVVUZkx0bUtUQmJDZE5KT1F5WWFzOHgvUHZqL0Uw?=
 =?utf-8?B?V1JQS0ZKZE95ZFBzZlRrQWFDWVZuTEtwL3I4OTA0YjZMODI5YVYwZkt0Mmpi?=
 =?utf-8?B?Qlh4c1lJeFFPcUIvUzVsU0FsOXMwUm43ZEVRMExqeWc5Y3dWdFZEVGYrL1RY?=
 =?utf-8?B?cm9nN2U2M0U0b0ZOdS9NUi9rREZFK3ZxQVl5TXIrQ3RiQ2NSMXB4ZDkzMExN?=
 =?utf-8?B?Tk0wamZWczVHVXlDQ29Ham5pVG9Pem9ZQ2l1YVJ4VjkrMVBlaXNYbDl6bW93?=
 =?utf-8?B?T1E1OXVjbW1raFdmTkk5NFRFTDVKcnE5TFpzeGJ6NTlZMVRubUR5QXI5eUIx?=
 =?utf-8?B?T3RuYW40RUIwRHFrRlZyd3RESndyc2ZuL0JYWFpPYUxBVWphOG8wU2lrcFZL?=
 =?utf-8?B?eHhsR2podWo0QmRwMGkzWEZtbEpxZFJ5VnUrcys5Y1lZR2tGVUh4TnV1NEpQ?=
 =?utf-8?B?ZmlMSjFYanAwYlNyeTFKd1pKaG5LMkFXbjcrQTlsMkxJQTFPUGhqV0VmMnY0?=
 =?utf-8?B?Q0JZdXJ1b0ltOE9PdXExTmd5UmVwU2VLcERNQ2poWWsrS1ZSOUdZazVUYmMr?=
 =?utf-8?B?aWtKdFBQTkYwQkdoM3ZDTXRNcDNKWXpod0lEcktVcmFCaklvOUFJc3czT3d2?=
 =?utf-8?B?YTBpTHg1SGhBRjRqelUwTnlYSVFVY3lTcHE4STRZWEk0V2pHQS9tb0ZSQXN0?=
 =?utf-8?B?TlVsNnF2ODJSbmFkM2hselk1Mkh6eGtPOVdQYUZaZmFYd1JoUkdhckdzTTZq?=
 =?utf-8?B?aFdQTGlKelNYVHJnc1pwam5mb240Z1JOL3ZLNnkwRlZFR1RFY2FqSEFqOEN2?=
 =?utf-8?B?WnVwd1BmMExHaTVTSnFRWG0zekVZTTF4Y3pxRXFiVXZSZjBJNU0yRDQ2REpq?=
 =?utf-8?B?WWxqeCtvb0FvQmROVFdGall3UDU1VUVoWXNJUzRQVVdUemZYUVpaQmRaQ0tr?=
 =?utf-8?B?bmFoRm1SMnRETFo4VGQ4RW1SZjFQVVVjODJmVXNHRnhWUVV2U3doaEI1UnFI?=
 =?utf-8?B?MXBqQ2FzWFVmd2ZIa1kwMmJMYWV5NWdibWhFT00xWk5Wa2dnalRNY0UwdWhx?=
 =?utf-8?B?OFZFRUkxOFRlNXY5K0dXUnJrSnNUcGJINHgzUWtuQ1JpTWZuNHpIdkp4SDUw?=
 =?utf-8?B?UUJrRjNud2ExTDFzWVBEQ0t3ZWN4UW5jNzg2Z0YwekhRRUdKT2N2bVBpOXV2?=
 =?utf-8?B?VmozejNRc3JaTnlFakdBZk1qN0h6eTQ0WkZDYm91d0tXdDVJaHdvUlJQUEU1?=
 =?utf-8?B?RnVKNmZmdUFZUk5oM2xNTDgxV0pHRlJ5TXBqUWhtRWEvTmptZ0dKNjRVdGJ0?=
 =?utf-8?B?cEhKUjhmMUs0RW04Sm9XTmlTdWdTOXg4ZVI0eFB1N1o1TFZPK0xlN1NqZUkr?=
 =?utf-8?B?WFlyZ3hEeGExK3FYK2ViMTFuTkV0dDNFeUoyVWhHc2ttSUViMEtZOEN3SjNi?=
 =?utf-8?B?NEVwNWd4alNHNFhXSlkwcElSY3NYdGhYUFBlSnpXUzQ2emVYajNYNlQ1dWI4?=
 =?utf-8?B?azRoL0htNzJRZnBlcXhWRXFQbTVGRTVVK1JvSTJrTXNmakRmekozL2pkd2Ni?=
 =?utf-8?B?Nys3NzM2NXRIR2ZPUHVXQXRGYWQyTzM2M2hrTWYydXU3RGZoWVBYcXFhbU8w?=
 =?utf-8?B?WEtEU2hqZ0duR2g2WnE0VVdKM1R4anE3ZEVmQUl1Zlg0U2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHNRN3phSEtmQVJ6b1V3VkZnUEJ3dkNKK0hhT0NqQXJZdG55bHNXWlY4ekFy?=
 =?utf-8?B?WjhQZitSNmdFdEU3eHdZcmVRMVNWSjdRYXd2bUFVNTlXSXVRc2VyVThHQ1c5?=
 =?utf-8?B?MDlqZXJYVUpScTZpMXJZS0Y4d0w0UDhmSm9pQm44cVluZHJQblArMlJlL1Ix?=
 =?utf-8?B?a21lc01RMXp6elhVLzZOK0p6d3lrbkF3c25MTWxFMlFYRFJZYyt2bGpUSnF5?=
 =?utf-8?B?YklYUTA5VTBicDN4YTRxUjVqandMcG1NZnlXOHZkdEJQSUQ2UW5aTTVTM3VD?=
 =?utf-8?B?cWV2MGthYTN6Y2d1NExtZ0tqZTQ2RGVJZ1VKZmRaS3F2d1ArclhhVldLdmZi?=
 =?utf-8?B?UGxxWEJDd3hPRmQwUldYUVRVb3lkUGd6RnRMREJhcjZWS0ZqZU5rVDhVVWI4?=
 =?utf-8?B?V01sQUdOOEZodkdOV0JnZUlHbnE1VnlxTU1tQ3RvSnlOUE51djg1UG9nbUhI?=
 =?utf-8?B?MUVYN0VXMGVJbllUV21zeUx6aXhuSmFMem8vdU1sVWIydHljUnJWTW8rcXRr?=
 =?utf-8?B?cmVMdzZTS05QWGUwc09mL3NVemQyWU83a21hbUpadnA4VTNqcDJ1NUtPeXJY?=
 =?utf-8?B?ZGhwT0hETTJkSXQxSFVaM2NKZ1lhcWRic25qUWpwaXRXRnMwbGdkQnFEL2lj?=
 =?utf-8?B?MnIrTEVyL2VBYVAwYlFiL3JKN2E2WHpDV25QYVYzWE9OOHdMUktkUWZPK0pJ?=
 =?utf-8?B?Q25xZVZNQU5SU2daM3NaYlFodjBNSjY0MDAveE80QkxtUXp1R2p0R0ttMnk4?=
 =?utf-8?B?MlE3ZUpsRE9kRU9JNG9oQS9CYXZPQlNXNzBjOWx3c2tFYVFzTUpNWEdKeHFk?=
 =?utf-8?B?aytZUktpMy9pWjgrWk01bkxuRENodEdVK2N6eWZuV0I0WFNzZFlJWnJZZFU2?=
 =?utf-8?B?aEloeWEvYzNianNveHpOMVJFaXFWUGdGc256S2JwNGI4cyswVkJPWitOdk9a?=
 =?utf-8?B?WEVxWjVveW43aVQ2czB4aGxjNUtZd2tvRGZyN3RHOWU0N2lBV0ZlRWo4UXFr?=
 =?utf-8?B?bG1laGRjcUtBUlJnNlJmbFFBaGZjc2ErSml4eTBHbHBoZ21ZcUlSMys3TWtk?=
 =?utf-8?B?MS9QUjFMU1Z3MTJvQjZkWEh6aGR6Rlp6ME9IS1dPSEkyMTRrNElWYm5LaDZk?=
 =?utf-8?B?VU5HYlhqVG9tUTc5WVltTlk5YjIrY2RqSTJ5Qzc3TzNxK05PcmV4M0RrMFBX?=
 =?utf-8?B?RnRKOHRvWVdnekhiSjByNVJIYzRRenJDSitiMWFCNy9MSFd6ck82Mk95cTd6?=
 =?utf-8?B?YjhFbjhHN3k3VVRUVmc1MngvRDdPc1prSmtDdWR1eXR1MUNYRXdLWG5pb3M2?=
 =?utf-8?B?R09COXBXQ1orT2REMVJpalM1SDd6cy9sYTFPR3QyS2VMd0dtTXFwZkNOcDc2?=
 =?utf-8?B?dGk3NnFTY1J4cDc2ZkVGa3lJMG5GYTR5SHdBeUtqdUdMUDIyb0dCK2FlT0Jz?=
 =?utf-8?B?VkF0dWtkTXNDTjVVb1hKNkx1K3FTalViYWtXckxrL0M5a2hnTnZlMS9GVjhV?=
 =?utf-8?B?bWg3aG8xT0tEZXR0S21SbDlCSGN5VDJvbU1CbkVXbFA2Y1lqS1dKNHJSWlF6?=
 =?utf-8?B?b3pKOGlwYXNac3JpNEZ4MStkdEVEOUhIM1RpNG9FMW5FeUdGeE1ZZjVCWTZh?=
 =?utf-8?B?bXFIODk2bFVYMmdKOVhwUVpwc0Z6cERWTnBLeW8vcGtCVldoR1lDazZLbGlo?=
 =?utf-8?B?eHlwKzF6S1dER2YybnVscjRwd1lMcUx0a0gzbk5ISmZEUnYvZFpIR2RlaUZs?=
 =?utf-8?B?RkgxRHc2UjlvVzkrV1FtcDVGb3hDK1F2N3gxdk0vMDJEZmNnVGV1NHpQQUZ4?=
 =?utf-8?B?OWNYOTRucExyaUFKZDRFQWhGK0VDYXpSNGtHdzZFNXhNeXpWOWM5aGVBUzBw?=
 =?utf-8?B?QkFINzhYc0lTakt3SXpRMkxEa0dqTVVRTEpxK1NNdVNCTnJibjFRNHZMT0lO?=
 =?utf-8?B?MHBlTUJPU1JzZWJ0NFRQYzZQc1RNSU1Ca0pJTUdMcmhMWkxOcFhLTXZ0V0tO?=
 =?utf-8?B?MHowckNGcVFuSE5mYzF5azlWS1pjV2JUY1l4RytaTloydFFrWTg3akl2bDdG?=
 =?utf-8?B?bW1qUWJ5M0UzQkxTV2JQc1dzR3ZFcmh1R0RIQUVYNm55b3J6Vmw3SjNUeHM4?=
 =?utf-8?B?OUpjMThPcWVxc3RyMkdqRVIyMlVzY0tOb095dXFBWWtPSzEyYU1lVytTU3Y1?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E041E0E94534C4F9B52D735CAEB46E6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd48811b-69bb-4772-b86c-08dcb6985d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 04:21:09.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ml26fxTIp2QM32JCvGdTxPKPKnTADYZ2z2uQ00GoNqIuU1d7bCthkFcjLkk3dJe5PleQNKuauJ1TRJo6sc9ODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7308
X-MTK: N

T24gVGh1LCAyMDI0LTA4LTAxIGF0IDE2OjQzICswODAwLCB5ci55YW5nIHdyb3RlOg0KPiBGcm9t
OiBZUiBZYW5nIDx5ci55YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEFkZCBBRkUgQ29udHJvbCBS
ZWdpc3RlciAwIHRvIHRoZSB2b2xhdGlsZV9yZWdpc3Rlci4NCj4gQUZFX0RBQ19DT04wIGNhbiBi
ZSBtb2RpZmllZCBieSBib3RoIHRoZSBTT0YgYW5kIEFMU0EgZHJpdmVycy4NCj4gSWYgdGhpcyBy
ZWdpc3RlciBpcyByZWFkIGFuZCB3cml0dGVuIGluIGNhY2hlIG1vZGUsIHRoZSBjYWNoZWQgdmFs
dWUNCj4gbWlnaHQgbm90IHJlZmxlY3QgdGhlIGFjdHVhbCB2YWx1ZSB3aGVuIHRoZSByZWdpc3Rl
ciBpcyBtb2RpZmllZCBieQ0KPiBhbm90aGVyIGRyaXZlci4gSXQgY2FuIGNhdXNlIHBsYXliYWNr
IG9yIGNhcHR1cmUgZmFpbHVyZXMuIFRoZXJlZm9yZSwNCj4gaXQgaXMgbmVjZXNzYXJ5IHRvIGFk
ZCBBRkVfREFDX0NPTjAgdG8gdGhlIGxpc3Qgb2Ygdm9sYXRpbGUNCj4gcmVnaXN0ZXJzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogWVIgWWFuZyA8eXIueWFuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0K
PiANClJldmlld2VkLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQoNCg0K
VGhhbmtzLA0KVHJldm9yDQo=

