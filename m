Return-Path: <linux-kernel+bounces-250286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFCB92F61A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CB0B21630
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4562E13DBAA;
	Fri, 12 Jul 2024 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nutFdYaA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="keMaSt4R"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0529CF4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769034; cv=fail; b=BvNgor1SXuQbPr7DdvERJm0Q1aGoGk+X5O+lxvFWCiry/TkNKc4oc8ZKIPrBnVKJnB7aFxgPhuE9fWCHiY4a++LdBD53R2kE+8D6ljNcsrsS1v7tqF5Ds4XH+F50HfqD6GpGYpxwf411LL6NIfM2yX/Nb2SPd+X7IA8YgEHH/VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769034; c=relaxed/simple;
	bh=5d89M2nPlJ4Uxo/PoAT68o+YdQsx+08YEk+vY+PG/1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lWoCa+0Z2L8KoNKgsK35E0TTiU901WkNKpjgrX+SJf+6LaDonQ62anqup7WHPEupefaJBJ1lqhzi5iwynIPD9XhL1UY1+atlmzIzGTDlwzenpiwCC+KzZO/LdwvE3UrURFNU/RVKi+ZgHtz2WOsaMG/bNHjhHbjK7vYGixemTXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nutFdYaA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=keMaSt4R; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: acbc92f4401f11efb5b96b43b535fdb4-20240712
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5d89M2nPlJ4Uxo/PoAT68o+YdQsx+08YEk+vY+PG/1A=;
	b=nutFdYaAsuM6iqRNWGyqcqHe9B1n9wQeYuFbeb99Tpyr3EmhDaBkEGgYs07y4MYdDCPQwLZ0Mc50U+MquYWS2+FZzuW5+LFwnu+aZrRmI4Y/pleZyo84BGtkt7opqYaLWHZybjveqWcjvtUPv1CFNzwLPpWC0n3b12JFHQGYD/U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:e18baa6b-6df3-4800-842c-6e8cb9e88149,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:05be42d5-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: acbc92f4401f11efb5b96b43b535fdb4-20240712
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 33090751; Fri, 12 Jul 2024 15:23:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jul 2024 15:23:45 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jul 2024 15:23:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3kl62f/Upm5UyFtsDFAKnLRFW6Ub90w5lyYggnGHVPpvjKsPBkpCUfyGCcY3viqrR0Q98HKWj7/QUgQAsUTEfj1V9xWTWpPvrfx1AF3LMCyvWK/wtFsvy+vpnOqglDzpyyxAfuaHNdAmJJloLeBYaGZdKd8z8kxF1AfH9dY7jMyah79WlMktlD0moYVfmimik2+YxWmu7R9xNUmPpdAg2FAbcUJkLc8EGmpvuw8dotCtLvqh4WW57Jw3IhVxYKxGL8/akZLYdGmlTaBlSEC9zihZ3V49dE1mmLy3F3U9bKxDjzS7Iqrd27Z9zBJdyQ5YqDxURra+yJSUuaKMobEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d89M2nPlJ4Uxo/PoAT68o+YdQsx+08YEk+vY+PG/1A=;
 b=NWFBcD4aNbrV8z43jAID70JGkS3nu9PB+hrpca7qg75A3B+MVlZf7VT+VQHUyUKRTDWV3/lI1EJH6mYzvIXK9LQda20OVikLgBuCXIs1LJMGGw0AKgD3UCvR26tF+eVBEdLXkNJPaptmB50vvRfy4OkJXKCTpg2DMRCVBg2sSD/M4itQ8ZX0mHqpyiHihla+F7EC91ti+1D9/tebhLIIYHln8hBVnOo/ntC3kPn5e41w60/nAEoH7n8SSYpOrBB1eEfiObyaO57RxI1FPOzGABYfgmaK8JGHnBAAj+sUStn3xZEJmsqz6SUfcXfWB/6hqM4cLua3L4KwwWE8HxDlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d89M2nPlJ4Uxo/PoAT68o+YdQsx+08YEk+vY+PG/1A=;
 b=keMaSt4RubPoUYwTqVCuKmkVM05SUMpMczCMAZDOnd5YhZiX6N2gp8MtoxcqEfqKPe0qCoGiOzrxUSI+fIbjkLw3IrV/drOq7GCyXyyd/+Mp1cpIjy5wB6pQgNDkAcqygADGWRfUcwmkZgxPmbMyCS+m7lVXfAgN5SIaf/YFO20=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TY0PR03MB8331.apcprd03.prod.outlook.com (2603:1096:405:1b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 07:23:43 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 07:23:42 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
Thread-Topic: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
Thread-Index: AQHavg+NdbRKcT+3skGSUl4IqMicy7HMSVSAgADxdQCAAHoqAIABEY4AgAB6xoCAAPnzgIAAh/UAgAYULICAAGkzgIAApk4AgAALTYCAAek2AIACwj0AgAi2BgCAACiYgIACTBWAgACwkoCACHc+gIAAHd6AgAHOu4A=
Date: Fri, 12 Jul 2024 07:23:42 +0000
Message-ID: <c8081a0bbfa2f60fc3d594bd0fadacf9354507b7.camel@mediatek.com>
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
	 <20240614040133.24967-3-jason-jh.lin@mediatek.com>
	 <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
	 <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
	 <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com>
	 <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com>
	 <CABb+yY1Yy8o3ofAiC-uV+gDrO3QDTWz3_XTUMai_2uyrnj-VrQ@mail.gmail.com>
	 <b7ebc021d391452eaf2149976ea2d53fba3d89fc.camel@mediatek.com>
	 <CABb+yY3+pnuXDK_jZMDYOAzahdSZ5iig51VqzM=FFHrFpK+9LA@mail.gmail.com>
	 <4e5d4362-4940-4ba0-95aa-627b82e21e41@collabora.com>
	 <CABb+yY3eXvJRUq7MOqB8QZ9N4aiuogaUCTfP7MerKdNbAbLkvw@mail.gmail.com>
	 <895af04e45d286c38d01f48b29ad41598b7dadb7.camel@mediatek.com>
	 <CABb+yY1EZOsKUR7WUX0Ni0Ukbqz0+yRHswiu07tNXtY1A1gNUQ@mail.gmail.com>
	 <d6f0e7072ec0e89e573e5720fb2b9c621eb9154c.camel@mediatek.com>
	 <CABb+yY0+fFw7Bg578DFEdrigVFgf4-v3qo2JVruEa3ExtvRsMg@mail.gmail.com>
	 <092d917b4cae2762317a8739c874855554ae913f.camel@mediatek.com>
	 <CABb+yY2-KWYORo_-ZWafyM0VJnh8-2wefvCpeDsK204qB0TchQ@mail.gmail.com>
	 <3f655bc4e1e60cd5e0dfc9baa018553fa8892826.camel@mediatek.com>
	 <CABb+yY2zBY_3nEYajdhRNfwb+bPMpFOvbXrqY+jM9rB6qbjJNQ@mail.gmail.com>
	 <e860d67f578f1963d785dcc0423936fe5de20547.camel@mediatek.com>
	 <CABb+yY0mYrUyfpNLVKZt2aDdzZPf+VjawcwVSpMG8H_=pwKLbw@mail.gmail.com>
In-Reply-To: <CABb+yY0mYrUyfpNLVKZt2aDdzZPf+VjawcwVSpMG8H_=pwKLbw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TY0PR03MB8331:EE_
x-ms-office365-filtering-correlation-id: 574da250-e635-4682-b8f6-08dca2438f17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T0JEeGVCZVpjd3VXMVlHMXRpRHRCRXQ1QnBHLzJjbVU2ZWhqU1JrTmZlSmhT?=
 =?utf-8?B?UzRvUlorbi96dEhac2t0a093SGRYdUIxWHEwNUlGekp3Yks4NSs3Y0R5bVlF?=
 =?utf-8?B?L2hwd3hCSnFTYnBDbGxPa3VCNkRNZDQ1Y2RxVTVJdm85MVJCaWI2VWFQTmEw?=
 =?utf-8?B?SmJ5Tm8xWk9TR1FzZVRqOXVPNGtqYnhwMEE2Q1B1SFdEVzJVcjd5VE1rQ1pY?=
 =?utf-8?B?YnlEQjNNVVBPcmZQaGp1YmZ6RGhPT0h2ekE1b0d3QmVxQzVrczhtUjBWdDRa?=
 =?utf-8?B?ODhoelpRcmg5YXJ1bENzZFFVVE4zc0JYdXNnR2grcVBEdFd2UC9yTG1GeWs3?=
 =?utf-8?B?OXRUWk9palA5eHh0SmpoUjZJVVdRQzEzQndkY1lNK1RYQjRycElEQ3FEd3c2?=
 =?utf-8?B?Tk5nU0hSZFo0TTl4c3JUR2Frbk5sNXF4ZDlIZkFEb2RuRWp0VW9BZVRRbTh2?=
 =?utf-8?B?Sm4wVnAwQUNPaHM3SDZyYmpSMWhSaUszR2dnak55RmpzUUVzazkxb2tmWE5K?=
 =?utf-8?B?ZFNPb0JIRXZyRDd4Nk5LblJmVk0xZXVQd0xjRklLWVNyeU12M0JWMVIxa2J1?=
 =?utf-8?B?Mk9iOU1ZWTV1V0tjWE8zT0NiSnQwQ3hDeUNYdFl4aWlydzlpbzhJTGM0TjE5?=
 =?utf-8?B?dUUrQ25GdnAveUw3ODVzclB6cXQ0Wm9kZ1lHZnM4UkpyZGtLQlgzWCtrd0pq?=
 =?utf-8?B?K3c4dUU1eHVvQjlvT0F3d1F3VzZ4OG9lNk5IZENEUEJFUWxUM25EM3BaSmUr?=
 =?utf-8?B?bnlaT1p2cmFWS1pXZ25DcWEyZXhTMWF5Y0NVSHFvVU5KQXlpWlZGZlhmTklV?=
 =?utf-8?B?U0NoYXpZeU9uWFZNeWRSTVFOZzQvRXhWeStMYWtkdDFIZkFkMEtRU1JYVXk0?=
 =?utf-8?B?VFVRY29LamZTNVViRjNJTDJsTmJ5MG9PVlB6SkhKclgyZFdRQTZkaXVQOG9N?=
 =?utf-8?B?b3lPS0wxdzV4R2tzVjhuajVRNVgvbTBKL1VuMW92RUtqYUNERXB2bHVlK2pT?=
 =?utf-8?B?dGNrbjlmRkJIWUh0OU9SZkVpeitTUlZxUlhTaDBtNXRHVE5aVFNuakdVcGl2?=
 =?utf-8?B?Nk1ST29Id25sVXJSQTlXUEprM2pnR2hSY0RLKzhnVktlMWlmUmZBWlYvUFVY?=
 =?utf-8?B?QklmSXhmWVpXVnJraXppTzhFTnhkSnBJOC9Sb28yaURWcjVtaWM3M3poK3Q5?=
 =?utf-8?B?ekw0WG9ZKzdqRjIrUDA1R0J4eVFHcWNKTU9UVHdFVWVvMWZ1YXlpZEZyU1FI?=
 =?utf-8?B?SEpSbzE2VGZxNmY2cURyQ0RvYUxXUnRkRi8yTWp1Sy9VOXFTcytwVjJCT2ds?=
 =?utf-8?B?TEhSaVNacEEvLzVGOWRVd0tUSWRaM1ZBOHQwSTlTeHhIYXBkNmgzRi9qbHVa?=
 =?utf-8?B?ZjF3VVZIYk8yY0UyYVZtbGY3R1BKSDQ1UHljM0cxUkxZLytTeG5lVERzZWpp?=
 =?utf-8?B?cUw3OW9pUmw2K2lheUtPVU0zemxFdDllVGNuRXpKK0pHYW11b3pIVUN2TEhq?=
 =?utf-8?B?UnE0YWQ5eERsVFR6TE1JbnQxSWtkM3h2QUJEdUNZY0pXV2tROURmSmNSblJt?=
 =?utf-8?B?aHoxNXFXY2N3SVJxazlGZHBoOUx6MmhaOVpEcVdtOTJZWHNZMWlUQjQwWjV2?=
 =?utf-8?B?RzM3ZVlBWjhsTFNzMU5Uc3NhRGJPTTcybVZrS1FBWVdQNlpnQzRuS3oxelUw?=
 =?utf-8?B?UVZzN1BPdERxb0srY2xCTnhwYVlUME1jRGZTZEFqb1oxYksybTBhRWxyT0pR?=
 =?utf-8?B?YTU5RGJiTm1GQVpxQlRwbnpWditXMlh1MUdMaFJxMlpmQWd3ckNEeVZqcGh6?=
 =?utf-8?B?bFd0dFlPc2Q2ZlhFWTkweEJoaGM0WXcvUjFkNDhvVmpOV0JPZUtBajJvZ2ZP?=
 =?utf-8?B?eUI5OXlwUTd4QW5xRVJQd1dvejIycTFvWlcwSHZvL2hZWFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0ZjdUtGUVpvTFBvWTYwTUNEUHdEbnZsdmlTV0xlZFJFNWlKZmt6SWozQm1Z?=
 =?utf-8?B?UllMN0pUZVRYQ1kyMmkyRmphSEkyUTk0ZkxSN0RJQ0c2Mm5VVzhCeFFuUjd3?=
 =?utf-8?B?RHo0WlZDQmR1YU1rVEVLUUVERFlMWmtqdEloelhtOWxhaEhLMHdoQTRtc3N5?=
 =?utf-8?B?WHRrakJTZWYwYlhjNlJhdTV3TWdRbXAyMXo2U044a2VyKzAwOVJHeHBTaTZP?=
 =?utf-8?B?RTR0QVl5bDE3STRFeFMvSytXUFZtOFV6VEUyOEt1T3BFNllVWEVwL1RYanBR?=
 =?utf-8?B?dGJvbG5qUC83OHhoYXF5Ui80a2NQRGwyRGgvMU9TZEZBUWVGbGtzMVIxYlJU?=
 =?utf-8?B?bWQwNVRKVll6WUlZVnp1amgrSXdoaW1CTm90Tnl6QkFaYXprOHBFSkc2dm40?=
 =?utf-8?B?M0lCb3RYOXIybWxSQ0ZYL0NkVmtHbG9xMi9XYUIwRU1PSFF4R1U3clhCUW9Y?=
 =?utf-8?B?T3ZmbDc3ck5pOE9zR1RjQTF3dWowUVdnQTAvS2ZvK1dsTVQrVWJaeDkrUi9X?=
 =?utf-8?B?NHp3TGNLUlUxVFB2NEMrT1htcnJYQ0plRldhY2NyTlNTUHBDVy83Y3FLOHFR?=
 =?utf-8?B?ajNvaWdvejNOQUg4eURhNTFMMzliaFVFM0Q5QXlwNHlqNGV6VjZpRkVzdjBX?=
 =?utf-8?B?byt3QkoyNjd5dnh2dlUwcWtXcnR6M2lLY0MwQ0FqQkpNR1lmRXJuZGV0b2Jm?=
 =?utf-8?B?d3NNSDFEOHg1UHFPb3gwRTRnRFRYQ1dkRmdYRGd2RDJHVHdJUnZES0x1L3JY?=
 =?utf-8?B?Q3pSYkJFblozdUNEVFlLTDBiOE9IYVYxa0FBMGVLaVArRjBJT2ZiSUNvcFhP?=
 =?utf-8?B?VlRwSDJwd3FZYmNwR21EcUpMR1hMUjErRS8xWE5oMGxSbjI1SWRFZDc4OGht?=
 =?utf-8?B?cVNzUTA5c2FTWm15VTF0RWFqTzFFbUU3YU1mWFBCOTZwRTd5S2xDUHlSMnpr?=
 =?utf-8?B?Wll3SDJFeHNFUm5Fa0JzSWF1QVJOMC9IYjVXZTh5SkVieUdxdmhmOTFXR0lL?=
 =?utf-8?B?dVRndkp5blA5QVRBUVpTalh6ekY5Tm9CZFVyZURybFUvWTJJb1RFTUU2My9y?=
 =?utf-8?B?eHNxSU5OQlFydm1nUzhBMWVtT1dRNUlMNkd6OUhIVHV6YTgxVGh4N0NsTG45?=
 =?utf-8?B?b1dyRHY5cWt5dGxrZUpkaE5DSERuYzAyeTVqVnliWm5hWjNFdmJseGgySDM0?=
 =?utf-8?B?dEFJVU53YnRsdy9ISjN0VzhlQ3VnM1I2eExoL0hxSVQ2QnR3UXozeG05cXJL?=
 =?utf-8?B?TGJhbWQ4dmNPNFRkQ1J0U1RKb0ZteUJhSUtZM1FRVmthZzQ2QWVyM3IzZEZE?=
 =?utf-8?B?KytHeFJ0SkMxNVpjalNOV2NZQ2F1MG1tajF1VG1NSVVCRk5CZEtxajczWVNP?=
 =?utf-8?B?d2w3YnBROWplVzF6MTRyalhkeG9vclRsWVdrNXF4RTUyWHliUDE4V3pYNHUx?=
 =?utf-8?B?eFVTVDJDR2E5b1oyNE83dGptRmJiMm8xVGpvTDExNGRpV1h5bHJZVkNsdjUx?=
 =?utf-8?B?UzdJWXpFelV4WWZUUDhHZVRtMmVuczE2anZta2NOVDZFcDZUK0RQc0xnWGtr?=
 =?utf-8?B?d1ZoNmhhQlhnZ2VoQzBFQ3ZSTlJ0TUowTVd0Rkhld2ZwMEY3ZGI1NWxJUkp3?=
 =?utf-8?B?TlI5ZnMrL1JDajBUbWNrSTRBa2ZNcHp1M2JJbEdaNnB1WW55TElrUkQvZnJR?=
 =?utf-8?B?RlRQNDBXVlJ5UEdkYkJRc0F0cEQ1cEV5N1Mzd015Q0tDbEhVUzFpMEc1Z081?=
 =?utf-8?B?bUZKeUtUaFhlYU1CcnhENCtNblU5M1JZVTZDZ3BOc2RRNDJTTEhJdm00VEN1?=
 =?utf-8?B?OVV2TUFReUJmbXJJVUlLcXRkRlpVck1ZRnB2bm9Cby8za1Yyckc1ZHNUcnkw?=
 =?utf-8?B?UlNmc3ZDcjhYVmZxdnRYL1JaVGJjS3d0dnNTMDc2c2NzY3pEUHhEMWZDK0F1?=
 =?utf-8?B?WllXTTh2ZVFDWEt4akY2OVE0cDJzaUZxYUV3UEJPYVhZNnRuYWVLZHdHV2Fv?=
 =?utf-8?B?dCthejU5MklzTDAzUVlHSms3VTJJZ0hyYVFud3NVTG5UMlhHcDliZWpkMHpM?=
 =?utf-8?B?a1JEc2JoMlgxcXFXSVRRbjJwcVRVbGVqY1hmN1hzMEZsc2NNWVZua0sxbHBu?=
 =?utf-8?B?dUYyMHowNjE1RVpTbTVMcDBGckZyMlI1QjRQY2NBdEprVk45N1dTZGtHTlg5?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3036A3624344C4798DEC5D96A6031DC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574da250-e635-4682-b8f6-08dca2438f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 07:23:42.6463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0K6VsVDqcrh6B/X3rDyMygmoYnE8aQeIHgCs+rNWzvmSGtLL5srf3ubM/DSCHxppfbjdQkxeE9B8x3MPHIICrBa6dkxy7bMtzLtoT9wfiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8331
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--30.103300-8.000000
X-TMASE-MatchedRID: X4bcv0S75Kk6yy6RAAEPcya1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCpGpaLcbZyfwmlaAItiONP3XAvRa0tfJGl9eTSR8I6duJKi
	pJgRx1kO9ARb4GqetWhEMeZvj8UyyHVikQ9YmLLNPuMJi/ZAk8fQ7szeVKdNbfmBSyEqHyB8fPl
	xxE3mQs+qDbsXjlf43fkm3lgvG3csLd3u89FoqUWA/V00XWjDtTI0NfY99MMltGYTovTq6lhSHq
	BuoSMtNBDJZsWaVaTEXNPRK5z71bFLrVDh8B2c0oaP4nSNLOYsg0L4Xy2OHlfqh2SbpugCfcD5M
	H/FdXeCwLtAgcCa0hGnhUL4Tgbhg5UcZtwNsCrrSBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq5
	d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--30.103300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F2B9859936A1FA763FE1C683AD0A93A2393448A70C8B69264276D0E3BE7571E52000:8

T24gV2VkLCAyMDI0LTA3LTEwIGF0IDIyOjQ3IC0wNTAwLCBKYXNzaSBCcmFyIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIE9uIFdlZCwgSnVsIDEwLCAyMDI0IGF0IDk6MDDigK9QTSBKYXNvbi1KSCBM
aW4gKOael+edv+elpSkNCj4gPEphc29uLUpILkxpbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gT24gRnJpLCAyMDI0LTA3LTA1IGF0IDExOjQzIC0wNTAwLCBKYXNzaSBCcmFyIHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gIE9uIEZyaSwgSnVsIDUsIDIwMjQgYXQg
MToxMeKAr0FNIEphc29uLUpIIExpbiAo5p6X552/56WlKQ0KPiA+ID4gPEphc29uLUpILkxpbkBt
ZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBbc25pcF0NCj4gPiA+ID4NCj4g
PiA+ID4gPiBZb3UgbWF5IGRpc2FibGUgb25lIHRvIG1ha2UgaXQgZWFzeSB0byBjYXB0dXJlLg0K
PiA+ID4gPiA+IE1ha2Ugc3VyZSB5b3VyIGtlcm5lbCBwcmludHMgaGF2ZSB0aW1lc3RhbXBzLg0K
PiA+ID4gPiA+IE92ZXIgeW91ciBwYXRjaHNldCwgYXBwbHkgdGhlIGZvbGxvd2luZyBkaWZmIGFu
ZCBleGVjdXRlIHlvdXINCj4gPiA+ID4gPiB1c2VjYXNlLg0KPiA+ID4gPiA+IFRoZW4gc2hhcmUN
Cj4gPiA+ID4gPiAgJCBkbWVzZyB8IGdyZXAgSmFzb24NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbWFpbGJveC5jDQo+ID4gPiBiL2RyaXZlcnMvbWFp
bGJveC9tYWlsYm94LmMNCj4gPiA+ID4gPiBpbmRleCBiYWZjYzdiMGMwYjhkLi45MGMwNjIwYzBh
ZTYzIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tYWlsYm94LmMNCj4g
PiA+ID4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbWFpbGJveC5jDQo+ID4gPiA+ID4gQEAgLTI4
NCw2ICsyODQsNyBAQCBpbnQgbWJveF9zZW5kX21lc3NhZ2Uoc3RydWN0IG1ib3hfY2hhbg0KPiAq
Y2hhbiwNCj4gPiA+ID4gPiB2b2lkICptc3NnKQ0KPiA+ID4gPiA+ICB7DQo+ID4gPiA+ID4gICBp
bnQgdDsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICsgcHJpbnRrKCJKYXNvbiAlczogJXBcbiIsIF9f
ZnVuY19fLCAodm9pZCAqKWNoYW4pOw0KPiA+ID4gPiA+ICAgaWYgKCFjaGFuIHx8ICFjaGFuLT5j
bCkNCj4gPiA+ID4gPiAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+ID4gPiBi
L2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+ID4gPiBpbmRleCAwMmNl
ZjNlZWUzNWE1Li42NDM2ZTFiMjJmMzUzIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gPiA+ID4gQEAgLTMxNyw2ICszMTcsNyBAQCBzdGF0
aWMgaW50IGNtZHFfcnVudGltZV9yZXN1bWUoc3RydWN0DQo+IGRldmljZQ0KPiA+ID4gPiA+ICpk
ZXYpDQo+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiAgIHN0cnVjdCBjbWRxICpjbWRxID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArIHByaW50aygiSmFzb24gJXM6
ICVwXG4iLCBfX2Z1bmNfXywgKHZvaWQgKilkZXYpOw0KPiA+ID4gPiA+ICAgcmV0dXJuIGNsa19i
dWxrX2VuYWJsZShjbWRxLT5wZGF0YS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKTsNCj4gPiA+ID4g
PiAgfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQEAgLTMyNCw2ICszMjUsNyBAQCBzdGF0aWMgaW50
IGNtZHFfcnVudGltZV9zdXNwZW5kKHN0cnVjdA0KPiBkZXZpY2UNCj4gPiA+ID4gPiAqZGV2KQ0K
PiA+ID4gPiA+ICB7DQo+ID4gPiA+ID4gICBzdHJ1Y3QgY21kcSAqY21kcSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKyBwcmludGsoIkphc29uICVzOiAlcFxu
IiwgX19mdW5jX18sICh2b2lkICopZGV2KTsNCj4gPiA+ID4gPiAgIGNsa19idWxrX2Rpc2FibGUo
Y21kcS0+cGRhdGEtPmdjZV9udW0sIGNtZHEtPmNsb2Nrcyk7DQo+ID4gPiA+ID4gICByZXR1cm4g
MDsNCj4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmtzDQo+ID4gPiA+DQo+
ID4gPiA+IEl0IHNlZW1zIENNRFEgZHJpdmVyIGlzIG5vdCBzdXNwZW5kIG92ZXIgMTAwbXMuDQo+
ID4gPiA+DQo+ID4gPiBoZXJlIGFyZSB0aGUgdGltZSBkZWx0YXMgaW4gbWlsbGktc2Vjb25kcw0K
PiA+ID4gMTAgNjAwNSA1MiA4NSAzMDQgNTkgMjcgMjAzIDI5IDI0IDI1IDM4IDMzIDU3IDM0IDIw
IDQxIDI4IDM2IDQ4DQo+IDcxIDM1DQo+ID4gPiAyMSA0NSA1MSAyMiAzMCA0NiA0NiAyMyAxNiAx
NiAxNiAxNiAxNiAxNyAxNyAzMSAxNiAxOSAzMSAxNiAxNiAxNw0KPiAxNg0KPiA+ID4gMTYgMTYg
MzIgMTcgMzIgMTcgMzAgMjEgMTYgMzIgMTggMzAgMjggMjUgMjkgMjQgMzEgMjcgMTYgMTcgMTkg
MzQNCj4gMzANCj4gPiA+IDE1IDMzIDE2IDM1IDM1IDI5IDE4IDMxIDE2IDE2IDE2IDE2IDE3IDMz
IDM1IDMzIDM5IDIwIDIxIDE0IDM0IDQ5DQo+IDIyDQo+ID4gPiA0MiAzMiAxMyAyMSAyNCA5IDEz
MCAyMyAzMiAzNSAzMSAzMiAxNiAxOCAzMSAzNiAzNyAyNiAxNCA2OCA3Ng0KPiAxMTENCj4gPiA+
IDUxNQ0KPiA+ID4gNDUyIDY0IDQ4NCA0ODcgNDk3IDUwMSA1MDcgMTYxIDMzNiA1MTYgNDg2IDQ5
NSA1MDQgNDk1IDUwNCA1MDENCj4gNTAwDQo+ID4gPiA0OTUNCj4gPiA+IDUwNyA0OTUgNDk5IDUw
NSA0OTYgNTAyIDUwMSA1MDIgNTAwIDQ5NSA1MDEgNTA3IDQ5OSA0OTkgNDk2IDUwNg0KPiA1MDEN
Cj4gPiA+IDQ5OCA1MDcgNDkwIDUwNCA0OTYgNTAxIDUwNiA0MTMgMjggMjA3IDMxNzMxIDM0NTUw
IDM3ODQgMzAgMjMNCj4gPiA+DQo+ID4gPiBGb3IgZGV0bGFzIDwxMDAgd2UgZG9uJ3QgZXhwZWN0
IHN1c3BlbmQgYmVjYXVzZSB5b3VyIHNldA0KPiA+ID4gYXV0b3N1c3BlbmRfZGVsYXkgdG8gMTAw
bXMuDQo+ID4gPiBGb3IgZGVsdGFzID4xMDAgeW91IHNob3VsZCBoYXZlIHNlZW4gc3VzcGVuZC4g
QXBwYXJlbnRseSB0aGUNCj4gY2hhbmdlcw0KPiA+ID4geW91IHdhbnQgaW4gdGhlIGFwaSBzdGls
bCBkb24ndCBoZWxwIHlvdS4NCj4gPg0KPiA+IEkgdGhpbmsgImRlbHRhcyA+IDEwMCBtcyBub3Qg
YXV0b3N1c3BlbmQiIGFuZCAiY2FsbGluZw0KPiA+IHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBpbiBh
dG9taWMgY29udGV4dCIgYXJlIDIgZGlmZmVyZW50IHByb2JsZW1zLg0KPiA+DQo+IEZpeGluZyB0
aGUgZmlyc3QgbWF5IGF2b2lkIHRoZSBuZWVkIG9mIHRoZSBzZWNvbmQgb24geW91ciBwbGF0Zm9y
bS4NCj4gDQo+ID4gPg0KPiA+ID4gQWxzbyBJIHNlZSBtZXNzYWdlcyBhcmUgYmVpbmcgc3VibWl0
dGVkIG9uIDQgY2hhbm5lbHMsIGJ1dCBvbmx5DQo+IGZvcg0KPiA+ID4gdGhlICAnMDAwMDAwMDAw
YTRkMzdiNScgY2hhbm5lbCBjbWRxX21ib3hfc2VuZF9kYXRhIGlzIGV2ZXINCj4gY2FsbGVkLg0K
PiA+ID4gVW5sZXNzIHlvdSBzZWxlY3RpdmVseSBwcmludGsgb25seSBmb3IgdGhhdCBjaGFubmVs
LCB5b3VyIGRyaXZlcg0KPiBoYXMNCj4gPiA+IHNvbWUgZXZlbiBmdW5kYW1lbnRhbCBwcm9ibGVt
cy4gIE1heWJlIHRyYWNlIHdpdGhvdXQgeW91ciBwYXRjaA0KPiBhbmQNCj4gPiA+IHdpdGggcG1f
cnVudGltZV94eHggY29tbWVudGVkIG91dCAodG8gYXZvaWQgc3RhY2sgZHVtcCkuDQo+ID4NCj4g
PiBJJ3ZlIGNvbmZpcm1lZCB0aGF0IGF1dG9zdXNwZW5kIGRpZG4ndCB3b3JrIHdpdGhvdXQgdGhl
c2UgQVBJDQo+IHBhdGNoZXMuDQo+ID4NCj4gWW91IG1lYW4gX3dpdGhfIHRoZSBhcGkgcGF0Y2hl
cy4gcmlnaHQ/IEJlY2F1c2UgSSBoYWQgc3VnZ2VzdGVkICJPdmVyDQo+IHlvdXIgcGF0Y2hzZXQs
IGFwcGx5IHRoZSBmb2xsb3dpbmcgZGlmZiAuLi4iDQoNCk5vIG1hdHRlciBfX3dpdGhfXyBvciBf
X3dpdGhvdXRfXyB0aGUgYXBpIHBhdGNoZXMsIGF1dG9zdXNwZW5kIGRpZG4ndA0Kd29yay4uLg0K
DQpXZSBoYXZlIHRvIGZpbmQgb3V0IHRoZSByZWFzb24gX193aXRob3V0X18gdGhlIGFwaSBwYXRj
aGVzLCB0aGVuIHNlZSBpZg0Kd2Ugc3RpbGwgbmVlZCB0aGUgYXBpIHBhdGNoZXMgdG8gZml4ICJj
YWxsaW5nIHNsZWVwIGluIGF0b21pYyBjb250ZXh0Ig0KcHJvYmxlbS4NCg0KUmVnYXJkcywNCkph
c29uLUpILkxpbg0KDQo+IA0KPiBjaGVlcnMuDQo=

