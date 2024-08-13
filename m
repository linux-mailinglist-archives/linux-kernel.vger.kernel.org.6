Return-Path: <linux-kernel+bounces-284419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAE79500C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB81F217BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2A217BB35;
	Tue, 13 Aug 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eFF+JKdR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OGhmV+/B"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24013C691
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539857; cv=fail; b=gU/vCts6OW0kfwejumWfx/y7Tfk8HRsyCgWN5sf7Q9FqOG7LMg7sWL6XGvNkLGoXTHEx1jBKDCin9wN9YUV44S9+tWWwRwfscplnGNuY2NRBHpMiLKjcXVMNi34QAScVkjlf/JVms6/eeeBSkc+/H04q0vWV3O8hDvtbdtaf2SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539857; c=relaxed/simple;
	bh=2tNbUfBQgHgSROKlnim8joSEwtBgoAv9HB+Qvd9dpD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CNJzbcVnSHWv/UHvGPaZgpyg71+OM6iCGtuk/NteBzF+ztHEe46ed0Zu57IPLNPK0+9AZa+63Fkvw/jf+pGY4UQOaFCBSFBmv0DzZR55fjN9tvqbDz3CuEsAPZkBfPGAy+vfe41SIuWc9/efnxtizgnUEbYL16RFW6JaD9yTyvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eFF+JKdR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OGhmV+/B; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723539855; x=1755075855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2tNbUfBQgHgSROKlnim8joSEwtBgoAv9HB+Qvd9dpD0=;
  b=eFF+JKdRHzcKEFJMpMbImxTBjMB2OvLxmmbk0Dzk884Do++GPFD23CcJ
   Q2hjlUXm8WFinG7jPNQXGADfgY9UG9yjy5MHe87ghwOAveOZkUsd231pd
   Gb/8bCIi4kI759yjvPlh5au/5BHx1LQPXWyiuTsrtWee3yd+Ki/A1kHZb
   oK8IC0QQ7JVeOkNbizljOzZy1BI7kgWHH8xRsST5Y4TvkiBju82xwp+VB
   n1b3YqrG0WUq+vO1ioVoJAKApZEXcW0B5+pbEaqPYtgSVfTq5j7oFu0A+
   cmwaYJSUYDIiSZ7HqcDIrben/ctF0tXhVD7rnQL35Jn7pBGiEV58QkcY6
   w==;
X-CSE-ConnectionGUID: n9Sp5RbaRUW0fFOoxl+0Cg==
X-CSE-MsgGUID: wGzdz0r2TqiNco1e6yaxKw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716220800"; 
   d="scan'208";a="24184660"
Received: from mail-westusazlp17010006.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.6])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2024 17:03:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo5/UO+kuf7dO0MTXOMuGbpvfVskPRywlIExauK5wBapvHXbYWS63SYc20hipXQNiWzc2+kWVF8+WXrUb72A6jDJsP59WP+BOXkU2iVWtH9mklqXI2aFxCXNpZab0F1o9GsdAjedCVp+duBhD9wqRJ4zpYRqvsJEiZhZfuBmfm8VDyL8C+JU5W4gbEQeGSpAiOklp6GKbL0pmQ6Pmicq9234kM90UFgPQAK9URhO5O4uGAeUV96gKPWBqy4j1XcVetdbe6fdXmDdRqj0Beu6aWsOClTL+/TYBkchUjlsFyLxP3MLxzYBojCPkMcJvUay4nFnu3kBmggdYJV47sQ/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4twhXU/hTjd72uBogUfmMAHmT2uwOOa2pl7UMWWktPU=;
 b=DZIM/tVJBHnrH3DDJ+r2lwgK+mVOZezUWq6/cQJTFfqygj/AKSgH1a8MPI7YMi4MaMugB9nqAPc6Ry9NP7XdOJNQPK0Q+n1uNC0hVZRGWS+fo/2oPEqIL+SqoFfS2lmNJ0iowoX2yO4exZGJlt0BtLXZVdn7ywiPiM1yviJShYKV+4X5GXgDgu+HD7avFcuCkPdA+LLvAecI9PQv7g+sKD406ONeET0E4Xo7XRO6B8FHFnW7F0a0DRVijlsMD6K1fTUx76Hl26OiWb1ZQtm/k9uuXyKVANgoZaSvyNgZEQt8Dckc2FyybXHsrHCb+ONenJdMjjpgbTo/XleqGa5OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4twhXU/hTjd72uBogUfmMAHmT2uwOOa2pl7UMWWktPU=;
 b=OGhmV+/B3d9vP30KESGez4f1R3ZbKE+VD6wZ6FxEZCSp9npe6J2jJ4jS6yVo2El6GlRpTezjRDCLWWLckIR8ZhhxHS63PbexQsuwE586k9Je76VcD/8IVF+ESqgFv6T56dnrR+7oA4K6nmdw6QtQnPDrTPF6ja5r3ZeS4BS+30w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CYYPR04MB9030.namprd04.prod.outlook.com (2603:10b6:930:bd::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.19; Tue, 13 Aug 2024 09:03:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 09:03:03 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jann Horn <jannh@google.com>
CC: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
	<glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
	<dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, Pekka
 Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo
 Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Roman
 Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Marco Elver <elver@google.com>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	David Sterba <dsterba@suse.cz>,
	"syzbot+263726e59eab6b442723@syzkaller.appspotmail.com"
	<syzbot+263726e59eab6b442723@syzkaller.appspotmail.com>
Subject: Re: [PATCH v8 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
Thread-Topic: [PATCH v8 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
Thread-Index: AQHa7V+aNJWuNJQxqEGdTCA84xSRzA==
Date: Tue, 13 Aug 2024 09:03:03 +0000
Message-ID: <vltpi3jesch5tgwutyot7xkggkl3pyem7eqbzobx4ptqkiyr47@vpbo2bgdtldm>
References: <20240809-kasan-tsbrcu-v8-0-aef4593f9532@google.com>
 <20240809-kasan-tsbrcu-v8-2-aef4593f9532@google.com>
In-Reply-To: <20240809-kasan-tsbrcu-v8-2-aef4593f9532@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CYYPR04MB9030:EE_
x-ms-office365-filtering-correlation-id: 46bf5952-472f-443a-99a9-08dcbb76bd43
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8coSqLX+6LPdSJDAaFM52MTqWFWcB1L7y7bnao69DzuNxEpUTvfED7KKh971?=
 =?us-ascii?Q?UsCivObhNUOfjCdhWJH1rSQnLpSGL1iIgf2Oar3LoNPRJRLDBtpRxpPmuhlI?=
 =?us-ascii?Q?bUuTnmbHh1vLALkkCnLOIbXpugyv564X3AsOaBTaTU0fXcA0wmBPE7Y6n5Y6?=
 =?us-ascii?Q?gAemuKrXgeqA4r6DNNuT9DdvONbxj3WOip+Cbp4P5UXTZJ70dKWOUs5bIJs5?=
 =?us-ascii?Q?J8roVW9c6NAKPPEB0oT2iHNSDev+WMZokULk5ODA76JdXQB17Yto4Rx3XHbm?=
 =?us-ascii?Q?ubkPgRPS3FatPWS0yX9AEPidB48vcw92XQCeRzN9MM5uCBv1++QlKQxMLO6F?=
 =?us-ascii?Q?SnDK22jI0g0Afl5dFOIOJ8y/MzpQenviHoq4RGK6iNuVLhqTpgQP4W+p7HbT?=
 =?us-ascii?Q?YgwkvQK9uOdT8GPpQXqeUNAQqzu9NK+SaUpjd1Ubu0MUFMSOdTm6nW6yFGqI?=
 =?us-ascii?Q?adY9WzmHBfyIWrxUzDbfQtEpnlEe+03GTGu9mdrZHKApv52D7QoYSN892Thd?=
 =?us-ascii?Q?OSxR31iD2o51ugiUAmGUfS1o9Wro5DsZojG0yPJ/gEzzOgJu37EZIRW95VVi?=
 =?us-ascii?Q?sc3pDvxrgDHANLN7aG/ETLTVFYJOVagHRdMKrrIQuJNgW1Lu69/AW+G6dlg2?=
 =?us-ascii?Q?WlOfis77eMfwaP0pAhEGB6aHCOtdOxwAt8QzWyTx9pMshgxoDN4s89MRnKVo?=
 =?us-ascii?Q?Od8ysvSMSuzV/28w+q8XxYjuW4AXUThw5Hxo4xqhIRzHffPyowwq4HNibYAk?=
 =?us-ascii?Q?4otNeuBgQlyMLGcqCBZyNOcsVsid8L9jf5J16MCHc3x0lGPiucDbw5mbK+by?=
 =?us-ascii?Q?55HdLPRx5+x3sZqEr0MlFoReFIPgtV8R3wUUboiSHURAzzYDhKKJnto0bbYt?=
 =?us-ascii?Q?HvOkqFnbQk3bOvJjAgZmxVWOp1Pq1QEoGiA09jDbrNB7bsIQ2aEGKPcqBrEh?=
 =?us-ascii?Q?Euy7a4vidJ39XIT28A5g3JKQRr9R5pTw9d7hdctPnxAjEccJYCvz9XXIEj+G?=
 =?us-ascii?Q?G83x/uYSb9RNKh7oyKTn2uM1qYBjCE+Lh+5HjPugaNJJ76iCnp5zHw4iJ035?=
 =?us-ascii?Q?6xoc1eQLJgd8w0w7a2Bpzzdw26oULN3ixtcei7ElwDCs/3qJtSgWIBO2zEla?=
 =?us-ascii?Q?i2mrngAAZrkYkUgGmG+8lXqmH6U9Ikp7jkmqmivQfgKW4TDakRwRz+0TJM95?=
 =?us-ascii?Q?PJmNRw2uxYvjfdjpbEdgmXAz+QMFrEJDPt44ei+vEvxH8Myyxr/fSyvPb/OO?=
 =?us-ascii?Q?/cCFVfQKhHXMWiL39LCPSustHyaNqr79vQ6BrguE2ixS/9XLWs12m+WikHLb?=
 =?us-ascii?Q?cTA3LZh+KE7AaH3oOTDexv2QRu6YB5I8yuFWTP2aJ1QCjvVwn4OGHRz4o5sR?=
 =?us-ascii?Q?QKntCGfk4YRxy7464IPX48uR2ee3eQArXJ/G61q2gFV6/OHyIg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WgZOy94GEo8p2HdyYUFN/d0U1rljaKWe9pczvRkkOX++Z8vota9UvabHvJgj?=
 =?us-ascii?Q?VbJvc5eXZOj5XF6yMGgZw0WVn6kut1JI4KdqBfAqvVsgXP4/BbSv6Rttda8s?=
 =?us-ascii?Q?Q6/PClF4VA8itH2hxEzXKnifEw8cOLggvmMGL0e5R0GQa8R03XiTfR+kudxE?=
 =?us-ascii?Q?4TyzsjsDoB1iRTHCvdRVeoejlX/T6vqeKW9HMRr71E5jXHXNul/H8XZ1L76T?=
 =?us-ascii?Q?wR1gVemv3uWavcGU8XnCyZc+/ksdnh/AtjA5W/f44fmn8XlOwuMeEAp/K46g?=
 =?us-ascii?Q?mhnxmmKZj5Wf/AllHtqVtXvuIGb248Y3zZdn8BB5LzqVEbprFwFYbh+NiFuZ?=
 =?us-ascii?Q?DcIu8Db74gwLKAFm/qadtbayZLuAuVkFnp2E5KB8VTmfpl019NjPEDJT1Hw0?=
 =?us-ascii?Q?/b3duTfACTi9/PwSaWJ9sFHr4HKaq3ilbvTc/KJLmZ8WGIqjTngnIBks/Amt?=
 =?us-ascii?Q?ydBpiuorIWD6VOFmAE9gH1o4gG7bJ4dpbbcnpndIR0YOzG6L5u9EVf09Tswo?=
 =?us-ascii?Q?rqbfIH0BuTD4NKUsTPFk7+/IdZn1MVy4Yers0s1zeql+ah/rUO4rMDzDCXO2?=
 =?us-ascii?Q?aK/qp37EN4y97oCg9/zQMILDQInlRDlRMwJTA2hcqgUDIG3ZesOgvEK9/HDn?=
 =?us-ascii?Q?vGKiIlEFZdZZ7ON+J5GD8fCUM3jnOvzqYuok5JSiPo2birbd7i9A6zj42mof?=
 =?us-ascii?Q?MqVB9sdL+tagqbSSQVyul69vInGYFaU16GH49F7tJQ9sK6J8Sw9DwrwMIeMA?=
 =?us-ascii?Q?xOfKZWXbhrHfRDk5thgWwX7t77ZQEaDYLfqKsuYvd+pBUuXxIiWZ94PADqrF?=
 =?us-ascii?Q?HnUtstoACoMmZ95ZliZtl+OmzWIBqM6skROYwLYTc3eUYRxEwh/47pvYgYu0?=
 =?us-ascii?Q?jPbvvUiCG1KxjbuiYIwBTSgzev/Sm2QE/IDGIeYGz6L+Dp2TLiBmqKhLL47G?=
 =?us-ascii?Q?79QyBt96AIf04656b3wLwB/xjXTPI0t7uo9RCWVJOWyDH5wWaDHEOlyj8ePd?=
 =?us-ascii?Q?s7qzX0L5Qut6657XyEhMJ1b4/9901MUZ5acP9PeGpNS5yrkltBF3tEugBPUm?=
 =?us-ascii?Q?84BPHfkYl4T6U1lDHWwQMrftQe5xjRqLlrUwnucumXoeuRd6gJjbXsTlg74o?=
 =?us-ascii?Q?GmzbB+wTKfJVJP6DS2Bp4L51Tc3hoT56tiuZ69CbvenVGzy7RaOmmOGZHkgE?=
 =?us-ascii?Q?/vXoRSFQzGjw5mcY1YQUcHysAYPK/vlUIpEE1TtH3JBHLKiea/hC5SFvklc3?=
 =?us-ascii?Q?j29/qJv/4gb/54/kk6Hi8A0QrGxQig5B/70ZK2NHTYF6pEa8Y6TFdIPCluK3?=
 =?us-ascii?Q?RMHMUq/wdsAHjRuGpfmvUr9C5oUT3QUjJClBTVcN4hFHHExKJKwfmaAeB2ME?=
 =?us-ascii?Q?Cwo5LFasN2fbxkTwC/fwiBsY4Bp8i9KvJRjJ3ld6XOdrAMkAHowYmEP3q6g0?=
 =?us-ascii?Q?5mUAHmuwm42Py1uhhw1krEdkj3cCM0zPsu0tRA3an4BmjUeaYUxFyp3Vqtl6?=
 =?us-ascii?Q?znByx5A6BxqsKMyj0zEeG3oE7NQtmLBCQlUUbJBNwS6cf+O1GUTXMC9bCml9?=
 =?us-ascii?Q?mavYnsXGHsimRhKOFgJmZ0PxIMOT7CkP4S6N9lopkj5gqastUAV1DGyS0A+/?=
 =?us-ascii?Q?tZtf8CSw7+CaHkJShzclfcw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C91B75D4747BC44B891F5C921CD33BB2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eEm0UmV96YE22FJy5esY2N58xtHhiXZCcBcMDlC5c0dSLA+FHZtOsZwIjHfM7J1CvUNWw3cIQD9S9vB94XGc/Buy4xhCASbdqTg99wgBzuErxuJuiE41MRLAdLvyZh7es+fftrAq6tRKIJ9NITRDHAPUUbVy0ugqw3uOH2OCrbG7B3qSzrxll0WyZAVZbV8eVTeEYHzEzXZV+4DEEhg+m73QlXorHsF1OUx+h2QN7EMI5weA+wb+AxgNubLgXRmtK0j2XKhss8msXcWQD+h9a1OjyRO/Zw4ecFB7bVco6o1dL6b5wrcpKVh6ciFP7TQkU1bFbdve5SzPZS1AjAO6nw0F4mHwjFWvJQTi1ztP8IOHZ5hf8i3JPK1Kew69yf0DwVkL95UeQF4RCZNJ5brspq3hYKtd+UkfOCIb2PsuMg9wsHhdtUxRBOoXsRcalF/P/dX5GVlgupQTLkx7qi6hriKRGkBLCITkvPmUbSPIxDF/ftAGstNlGRbqeRIe14EL4eC4ehAVV/yxuVDAM+4IW/DYFjTrxm0yoCHtt3uFb34Qm5hU46v8JZkxGiiLBfcwkWM+On+NqW3l6YD5gVuqcduSNdBR4eDNjUpk0wO6bbBLMLJbHZzhxnhXccJEWZYB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bf5952-472f-443a-99a9-08dcbb76bd43
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 09:03:03.5373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bu+Aum/wUCih4Ao5P6lwuTfQbs/2lfiPh2SrSODzoAq/MM+z35HUxzBEu/clNTPLgGC1m8j+pTlDkBIoRKZzmNw31Dl5dWH89w7omCbkfpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB9030

Hello Jann, let me ask a question about this patch. When I tested the
next-20240808 kernel which includes this patch, I observed that
slab_free_after_rcu_debug() reports many WARNs. Please find my question in =
line.

On Aug 09, 2024 / 17:36, Jann Horn wrote:
> Currently, KASAN is unable to catch use-after-free in SLAB_TYPESAFE_BY_RC=
U
> slabs because use-after-free is allowed within the RCU grace period by
> design.
>=20
> Add a SLUB debugging feature which RCU-delays every individual
> kmem_cache_free() before either actually freeing the object or handing it
> off to KASAN, and change KASAN to poison freed objects as normal when thi=
s
> option is enabled.
>=20
> For now I've configured Kconfig.debug to default-enable this feature in t=
he
> KASAN GENERIC and SW_TAGS modes; I'm not enabling it by default in HW_TAG=
S
> mode because I'm not sure if it might have unwanted performance degradati=
on
> effects there.
>=20
> Note that this is mostly useful with KASAN in the quarantine-based GENERI=
C
> mode; SLAB_TYPESAFE_BY_RCU slabs are basically always also slabs with a
> ->ctor, and KASAN's assign_tag() currently has to assign fixed tags for
> those, reducing the effectiveness of SW_TAGS/HW_TAGS mode.
> (A possible future extension of this work would be to also let SLUB call
> the ->ctor() on every allocation instead of only when the slab page is
> allocated; then tag-based modes would be able to assign new tags on every
> reallocation.)

[...]

> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index afc72fde0f03..41a58536531d 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -67,12 +67,44 @@ config SLUB_DEBUG_ON
>  	  equivalent to specifying the "slab_debug" parameter on boot.
>  	  There is no support for more fine grained debug control like
>  	  possible with slab_debug=3Dxxx. SLUB debugging may be switched
>  	  off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
>  	  "slab_debug=3D-".
> =20
> +config SLUB_RCU_DEBUG
> +	bool "Enable UAF detection in TYPESAFE_BY_RCU caches (for KASAN)"
> +	depends on SLUB_DEBUG
> +	# SLUB_RCU_DEBUG should build fine without KASAN, but is currently usel=
ess
> +	# without KASAN, so mark it as a dependency of KASAN for now.
> +	depends on KASAN
> +	default KASAN_GENERIC || KASAN_SW_TAGS

When I tested the next-20240808 kernel which includes this patch, I saw the
SLUB_RCU_DEBUG was enabled because I enable KASAN_GENERIC and KASAN_SW_TAGS
for my test target kernels. I also enable KFENCE.

[...]

> +#ifdef CONFIG_SLUB_RCU_DEBUG
> +static void slab_free_after_rcu_debug(struct rcu_head *rcu_head)
> +{
> +	struct rcu_delayed_free *delayed_free =3D
> +			container_of(rcu_head, struct rcu_delayed_free, head);
> +	void *object =3D delayed_free->object;
> +	struct slab *slab =3D virt_to_slab(object);
> +	struct kmem_cache *s;
> +
> +	kfree(delayed_free);
> +
> +	if (WARN_ON(is_kfence_address(object)))
> +		return;

With the kernel configs above, I see the many WARNs are reported here.
When SLUB_RCU_DEBUG is enabled, should I disable KFENCE?=

