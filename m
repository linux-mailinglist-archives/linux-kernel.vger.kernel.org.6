Return-Path: <linux-kernel+bounces-399128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B839BFB6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB399282C2F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67120D26D;
	Thu,  7 Nov 2024 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="d4TNd4UK"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAA2119;
	Thu,  7 Nov 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942789; cv=fail; b=jE62PTkgZ9GmpgjxVIN0auxCsNIrLmlD0d4kZCVmrYff6kYSn1JxgbC828kDsl3Yhf/G9SEmHI/UxlQlJBwgB8HE+VhTLoLLg9cUI6VydlNEiJKi0cpqPwwvQ5+/krtV1bKs4xy2tNrRjx0Vw46CGPM4cIFstlsBpMzIkRX42nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942789; c=relaxed/simple;
	bh=35tXUvRYgLAIIAB4eH3R+hkB/vn4lVoqw35512ztN2w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UTCzcVEp6LpHe0Ql18oY63Kc5WBqkTSrilul1G6lU8Wqd8L7APGQjhfEBGSjN9MQ9n5FatcSelMQ4xD/e2ZRuxWdxHIQ0u0J60X7Ebu18GB7a2MH/xqsnSVMG4qJlEqraL1lLmT/uOG+pCmjI7y8m2hZmMV8TpjtJgE50q6KXZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=d4TNd4UK; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A710FQK025991;
	Thu, 7 Nov 2024 01:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=gz9xjz4vc0e5IM7TFxwBIP1riyzEd
	qLB1ln+h5YAMsk=; b=d4TNd4UKjT+OLywWRuJRQeKpkoP/ZxP20cJcSoFLAMrvc
	NerEw9zaJJYdKv8sZm9tHfs9+3nlqOhsUr24s55BKRb5bfEDXgCAOfKFZiMsDvvi
	XN3cBBeQEHn6Z6qjzjsSXdG/yxuZ5d74ajoPpnqjWkPo0MTLZtkv0dm+FlN80tbX
	BTc54nU1QkcE8qHBbNSIaD9wT8+cXLlYF20aa2fukLoafrsjLJps6LShW9WAwyoe
	JUr9FG0yco6h8y18vuNNouiaJn2WDIv9EnOre/NbxiaF43wOrM0FJh2fhNzTfLRh
	w5yvFVHEwGFy5JAaHaaihfFGpN6oJpfqNJCHZKCJg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42nc3tc0jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 01:26:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inx3pf14VgJIuVL47AmvK0HkHdK4Tp6+6hC6ER9blGxel20tXI6EEiLOArTKksgGsv9dp8JvLcn69JGJZt241omgmScx29kwk3zR3X/rGOBD41CkvO7KGpRjr4UbPFr+4bnxW/0h/ubSogLtVEAYgIWm+ONlkIHlGsA9lUXMTdIopenozft867n8nsgm0DnAdC8lH9zYD56DIzXB4fPcjO9WB4gaSOxaKRfEkLnh0CCwbfCt8ojBIJrjXnwrqDutnomy/Nq1ncU24hNynzez1Z9z9jFkdqzalJWt9zj7O1O2Z9w+HrQXPBlZFCny+BzNy/aLJ7klKpRizMCRfg5EGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz9xjz4vc0e5IM7TFxwBIP1riyzEdqLB1ln+h5YAMsk=;
 b=xnWpk8NeUh9tjP6yXQFLhok2ZpwWgfu9fNoO6ySsfLXqbFkLaVuKc+0NFCNsmsoKw8uDWcrureOstbln2nU9hPVFL8QAbtHTdF55+z1UdqOHe7RiirE3wkxtgLsP6pjsUrU3DgFAMFbhGQiWKj7clZYqLnjKQfAmL+qdlpu+PopjgQkuc9zYWjuZAaxELpJ3TZxdJQU00RQVdGE0XK4faAZQSNZHM8rX0ZB6vJa99Mn3KjxuHfbvzAYuA5rQLP3oLvXyqwZBzJlR4ojNop2f5zrtI1pmHXGiEhzTJeI2bDb/ebz6WMY9jvy3KUAq+0Pk1LOQ11NLobkSLJMJLzaVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by SJ2PR13MB6378.namprd13.prod.outlook.com (2603:10b6:a03:567::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 01:26:10 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 01:26:10 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [boot-time] RFC grab-boot-data.sh - tool to grab boot time data
Thread-Topic: [boot-time] RFC grab-boot-data.sh - tool to grab boot time data
Thread-Index: AdswrWifVP76ayJTRMK7KCYJOs7oiw==
Date: Thu, 7 Nov 2024 01:26:10 +0000
Message-ID:
 <MW5PR13MB5632F54DCBDA0C74370E531FFD5C2@MW5PR13MB5632.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|SJ2PR13MB6378:EE_
x-ms-office365-filtering-correlation-id: 6d4e2cd3-7abc-407e-fd3b-08dcfecb295e
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qrkZVZ15R+Jv7t0TVJ6aGgO1chzHEXyqR5LeK0RYSRab668MCUMM8qE3Gh9W?=
 =?us-ascii?Q?lUpJwH2vczLbNmZVrMRDdehmbGbfZq+CmC5HHcAiosfQekzfnySkKU3JFneh?=
 =?us-ascii?Q?31Y4AR/JEJLk2uoCTAnTM25IH2uf9IuwfhTcQqmcC810hwsxpb8HoypHWOxS?=
 =?us-ascii?Q?rOhitIV2KPVs0vFOowRVG12//vBFI2pfQPFAtAPMocUPyhDIngElSrNxUFsu?=
 =?us-ascii?Q?X3JaPV5kVkw02hn/6+qvpHM/YAclNGqQpX320xZoweLmS17BbR+FKo4bwS5I?=
 =?us-ascii?Q?iIOlYlBsZ97Hdi6Aza1WjI8kXqqE+9hUBzZ2iUHeX4cIT6ds1y3Tz0hPQQPL?=
 =?us-ascii?Q?WBkwqi4k0ch1/XazEe5JYJPTndQLMWyC6W2eLo8SbJA/C7/jw1iQ68yaOQvw?=
 =?us-ascii?Q?P//1qpyGg7dAsgI+AhxVPg1dndykCxzDSdKCL/54j83VICPp8MAw+wtqGBdy?=
 =?us-ascii?Q?LdmyPLe1d14nGHqmHIHP0qnORQGxT8E9vjH6oHXz6TM5vlLcPixORAg/crp/?=
 =?us-ascii?Q?YgC35o7MtAlxsSkTpV8wxex35zL6IU/J0fqfEq+3tdl0PMo3lkTIaiw2rTgO?=
 =?us-ascii?Q?R0VZGK6LFIu5pnd9+/d6YpOpaQ6ki34QQnKYrBIVTly5IVgLQ0EaC4OZPPHk?=
 =?us-ascii?Q?fMpwWU18mO/fpNcVLQijUV1oBlr6jwbey4ype/rZXNlr5YrPbQDdRXX5rItC?=
 =?us-ascii?Q?zGCNVNyuxLXRFoj1IMPs9HOx86WUDHnzWIsgB/CCaL+6wiV1ZyYiZPKsloD7?=
 =?us-ascii?Q?YQdKw5a+feSCUYhMhwl1X0mKUDt/Xf1TgQ0GydpmmphA58tUhqjH5qYtjQrv?=
 =?us-ascii?Q?DGT5hhw/R2e7nU373QvobKyQKEUlEDgpnsLLauoJDEUru5B/sGw29bDZty28?=
 =?us-ascii?Q?E7MgGskWPA0ppvFWrSJNEnGPeTtCbeW//42Jh8VouQrbu8eh2mXadfod/Qz7?=
 =?us-ascii?Q?nSOU8tKOdupu02IgKmsgzTCzhq7Q5LHWufUtz0wLU6pLIhIz3SOc6OzLy6zw?=
 =?us-ascii?Q?mbPFBEwNjaij25d1lKxtNok8fz92J3Y14nldFg8TQZMhyy4BTlGt6QxDObpP?=
 =?us-ascii?Q?pigY+7KdsrXidWAFgFHzZ0k7QrujbgUdZ3HjyuozK/+CxpA3ll/1Bsz8Y4bx?=
 =?us-ascii?Q?BZG8oeOreh5A0LCDWgKLc5pNEB3UJbJqWrUoJisha51BfqBo4pZTnaa+mU6k?=
 =?us-ascii?Q?lYKX0lL/595NFIGlrgWfTDPYdBNf4hVvdCPozAMGFaeTFG/lN6xULbsDWEFF?=
 =?us-ascii?Q?RppXdYS8+eRPV1Wwmi7O918OBR/3/s+OjEtP3kmI6+LguDMZeY7L7Lp8zdXC?=
 =?us-ascii?Q?GT7O5fkJJ3q3rYqnvZxVhV8d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v3tf96m90lyqb0nY3BqkF9tRC3sxupM5+Hh7+0GgOT/gc9FCGwVIKtAR4WIg?=
 =?us-ascii?Q?Ua0YczrS58vFDSIc17WSzhGPW8R5nduNuYQ22ii9hPQiiJsfUjhpN1CcdIZu?=
 =?us-ascii?Q?9f399q5AZDb/oGOzPizGyPrmRbepvw1s3UhRI+swtVPhoe7qpeOi4HzG8Sou?=
 =?us-ascii?Q?mp2GdHdO6/Ka/xtwywTMKNA3VWNWzhUa2OCH8teonqd0jUIorcSNT7mN1TOH?=
 =?us-ascii?Q?26/C39TaiSDxZsdC8RQzksGvhzm41zzY4BQ6xLQaisR/p1BCYlc/DPZ5RStG?=
 =?us-ascii?Q?/+XkTITH+VxeKu9rlI4y9JZUY9F+YZuW9KBhICJXckZQo48CiZGN5ZG4ZvEp?=
 =?us-ascii?Q?6AHhkSDLDLURrZiqfVgwxICBNXFrWhSGjrlkXJDwh3C5xwpOT3lFt8u3FR3p?=
 =?us-ascii?Q?Reaw/riymy1YPys/l5pwprIc2U07bT2/Z3SMDEFJ6OifD19ncV9QUaac63I8?=
 =?us-ascii?Q?oxicxj6CzL9Ar1fJtuGsyXajqAnbTaBU8sCf65cLMHc3l4sSaCUxe4WcMkww?=
 =?us-ascii?Q?Uip9PV3zgxEsbYLjbDWapNRmFqwzU4+JvI+S84D2CJdDbrV3zWEGqjTjn89T?=
 =?us-ascii?Q?GfX9KSfjvoiFpu+n/QPgQVKJCtLf6Az6cTziyCK0voOxO0hD2DbVEWf1usvm?=
 =?us-ascii?Q?ClOcG69b1f8BC8qjetr+6Xqp9+7IjD09B6KCGno7wh4b4B0XAx++0lSpfBMS?=
 =?us-ascii?Q?LrI07feDuUhMC0evgA8yYFNIUowi0dbnV0brS7OUzDyybYu8WmOX1f+ms+VV?=
 =?us-ascii?Q?abXkXlTA3WQNKWvWUlajfJ2yNZy9o6gUF3gyKx6it7ZBp65I0HujeIe1TvWs?=
 =?us-ascii?Q?fyi4RWfm1cQ4gx3TX+Ao58LLkwQ9Rb3e7HyQ06sSjbW7YGJSuMZvUnvctH+v?=
 =?us-ascii?Q?L2zNGkAaRq8rSo32BOHIMP6Ewop3sK5hKYpyd649arzJ1bedsVJTodGtEtbK?=
 =?us-ascii?Q?66L2Wel1dEi5PDJg2crHjgJHDFIPc8t40Pa/qYwhYUDgg+pg3DbDoUaZYu0S?=
 =?us-ascii?Q?eNnpdHbVVI2nmAIjbbREbY36Y//2Rus89eEpJSghMAY50cy+xzzC/9S1I8Lq?=
 =?us-ascii?Q?l7f/Ynl7Oznln1ahpb8XFLeSsIcZBNVru4I8KvvnB6RTWaZSCVVqdPkoNCr7?=
 =?us-ascii?Q?YpjvCJYRKOzEQMKeGKYYsa/gCWigkY0PLzl5x2mq2Nyefm3FTg3/7yPPbZcR?=
 =?us-ascii?Q?9q0Jx/z2LzlKGp7TxtspoUxstCwchVdiqIdaECsqBztd5e9951hrEC2fHOrV?=
 =?us-ascii?Q?M4FMI3xVWvze9kdN2JwnVOnM35jXJDzNZGWKSaxTZOHFplnQIP4DO9wRjuvS?=
 =?us-ascii?Q?/OAxmnZM1q9oWb+kQYOumXeh24R61rOesYXzycfEt6BWNcLTjkVcE8W5s0jp?=
 =?us-ascii?Q?sjX3IkaDXRdCV6T9KYsmr8ghGaYvk/tzZdqw7uzHO9cxXn5MdZOVLQbrud3o?=
 =?us-ascii?Q?1j2XgEVgKhB6/nSFS2bK0N437sg/oN13Uxm326XtiUlGv9MqY5bf8+Z7orDS?=
 =?us-ascii?Q?F1/uCF6Eif+DbksH1MsSBR2Bk3tUv4Ox83bvG793wELWOJNT31f8+GogkVhO?=
 =?us-ascii?Q?Sqn+wl4TEn4hDgIKJqQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LhUfz7J7xBmtxxAlJByN3a+KMber3RxDTz4OnKX5izmz1TwuNHbkr1VK+3A+U1qaQaixa3H7aQ3s3NtNOS9ZmB+H1a0dNBGHZytxWadq8RtDzj8BqToStjjmCkVa2nHvOUDWRyGaPfiKPIYOqyzX62A8RwLT9jyOR4zIJyLzHlfSagmMjbTsJlD04oyNjl/BV3ooUbz7ZzIpV/+9wg64uDfkhTqIXV69BxiKcXCcv2dLvPuU25v/dHd34Ld8BMP4gd+4DRyiXI4YChEMBSvTru+/AHdCbVqdPu12NZVypYNFyR1daHL8ZMX2dk9B7EGwy+ZgRMdFgY3GaxYyvkm4nYA7D9w1p/6xIYZuyMjFASXKxXYcduOTDmhTaD0iQhohzQlRd+sMPdpJazUjLZiSU+pxA0iAx0kFBCVYarIXGoq8uvSQKUNKuFZdApCE2S+w93qNYAw387ib7U8V8wXO9Eq907bjkrnn/sOtZQP88vKwBrLuP9TUdtLXtDmjE4QLjuwXqgCeQTmxtM++EZlP4zrl0NZI4DZpPmFmEiWTCLHVI0HG5YJdVfmXJ/Gk1FN/kpTmfDX8ywNQuSQZHc5HDAhoNWyfuzcYvhBxjbuSVZgNg3bD9QfmTunGW5AQ15+z
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4e2cd3-7abc-407e-fd3b-08dcfecb295e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 01:26:10.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFn+LGew6IN4qJhEj8md4NUpsAaHNuGOSiBFhY8TmxRiLpO5o6o1l6NDq9d9p0ap3F2Wtw2w/B0aibOAVrXrxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6378
X-Proofpoint-ORIG-GUID: LmgkEZatHfVPU9fxoKtHV-6PQIGwXYxI
X-Proofpoint-GUID: LmgkEZatHfVPU9fxoKtHV-6PQIGwXYxI
X-Sony-Outbound-GUID: LmgkEZatHfVPU9fxoKtHV-6PQIGwXYxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_20,2024-11-06_01,2024-09-30_01

Fellow boot time developers,

I'm writing to introduce a tool that I'd like people to run, to gather boot=
-time data on
their systems.  I'd like to collect boot-time data from a lot of different =
systems.

There are multiple reasons I'd like to collect this data, many of which are=
 explained
on this wiki page:
https://birdcloud.org/boot-time/Boot-time_Tools

The script uploads the data to my personal machine (birdcloud.org), and wil=
l
be accessible to the public on this page:
https://birdcloud.org/boot-time/Boot_Data

Please NOTE that this script automatically (unless overridden) sends the da=
ta to
one of my personal wikis, on birdcloud.org.  This is kind of a poor man's k=
cidb,
expressly intended to collect boot time data for off-DUT analysis.
(DUT =3D Device Under Test).  You can examine the script to see the operati=
ons
it performs, which include things like grabbing your kernel config, cat'ing=
=20
the running processes, getting your kernel boot messages, and showing memor=
y,
uptime, processors, mounts  and other machine info and kernel info.

If any of this might contain or reveal sensitive information (e.g. the name=
 of a
not-yet-released product, program or peripheral, or the attributes or capab=
ilities thereof),
then you should NOT run this script.

It is possible to run the script while suppressing the upload functionality=
, using
the -x option.  In that case, you can examine the actual data inside the bo=
ot-data
file, and determine if you think it contains any sensitive information befo=
re sending it.

There are multiple goals for collecting this data, including:
 * identifying printk messages (and thus boot operations) that are common t=
o all systems
 * collecting data about "common" timings for kernel operations and initcal=
ls
 * correlating operation timings with machine attributes (e.g. kernel versi=
on, cpu count,
cpu speed, memory size, kernel command line args, selected drivers, etc.)
 * detecting kernel operations that run before the clock is initialized on =
a system

Each of these goals is described in more detail on the ..Tools wiki page li=
sted above.
Please note that this personal wiki is meant solely as a repository of boot=
 data from this
one tool.  I plan to add some analysis tools and possibly visualization pag=
es for
the data in the coming months.  It is NOT where I plan to put the boot-time
pages related to tools, techniques, projects, etc for the boot-time SIG.  T=
hat is still
planned to be hosted on the elinux wiki.

The script text appears below, but you can also download a copy from the ..=
Tools wiki
page listed above.

=3D=3D Call for action =3D=3D
Please run this script on a system (or multiple systems), so that I can col=
lect data
for this effort.

Please also provide feedback on the script, the goals, and this overall app=
roach,
by responding to this email.  Please let me know what you think.

Thanks,
 -- Tim

---- script grab-boot-data.sh follows ----
#!/bin/sh
# grab-boot-data.sh
#  This is a simple script to grab boot time data from dmesg

# gather meta-data about the machine, so the effects of things like
# memory, cpu count, cpu frequency, bogomips, kernel command-line options,
# etc. can be correlated with the duration of specific boot operations

VERSION=3D"1.0"

# for testing
#UPLOAD_URL=3D"http://localhost:8000/cgi-bin/tbwiki.cgi/Boot_Data?action=3D=
do_upload"
UPLOAD_URL=3D"https://birdcloud.org/boot-time/Boot_Data?action=3Ddo_upload"

usage() {
    cat <<HERE
Usage: grab-boot-data.sh -l <lab> -m <machine> [options]

Collect machine information and boot data, and send it to the
birdcloud boot-time wiki, for analysis.

Normally, you run this soon after booting your machine.  You should
add the following kernel command line options to your boot configuration:
  quiet
  initcall_debug
  log_buf_len=3D10M

You may need to add these to a booloader configuration file, such
as grub.cfg (if using the 'grub' bootloader, or if using u-boot,
by editing the bootargs variable). See bootloader-specific documentation
for how to adjust the kernel command line for your boot.

Options:
 -h,--help  Show this online usage help
 -s         Skip kernel command-line checks
            Use this if you want to collect machine data and dmesg data,
            but didn't use 'quiet' or 'initcall_debug' on the kernel
            command line.

 -l <lab>   Specify lab (or user) name for data
 -m <name>  Specify machine name for data

 -d <dir>   Output the boot-data file to the indicated directory

 -x         Don't upload the data to the wiki (but still save the data
            to a file)

 -u <file>  Upload specified boot-data file to the wiki
            This should be used when the target doesn't have networking or
            is missing the curl command. In this case, use '-x' when
            running on the target machine, transfer the resulting
            data file to a machine that does have networking and curl,
            and then upload the file using -u.

--version   Show program version information
--debug     Show debug information while running
HERE
}

timestamp() {
date +"%y%m%d-%H%M%S"
}

OUTPUT_DIR=3D.

LAB=3D"unknown"
MACHINE=3D"unknown"

SAVE_ARGS=3D"$@"

# parse options
while [ -n "$1" ] ; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -s)
            echo "Skipping command line checks"
            SKIP_CMDLINE_CHECKS=3D1
            shift
            ;;
        -x)
            echo "Skipping upload"
            SKIP_UPLOAD=3D1
            shift
            ;;
        -d)
            shift
            OUTPUT_DIR=3D"$1"
            shift
            ;;
        -l)
            shift
            LAB=3D"$1"
            shift
            ;;
        -m)
            shift
            MACHINE=3D"$1"
            shift
            ;;
        -u)
            shift
            SKIP_CMDLINE_CHECKS=3D1
            SKIP_GRAB=3D1
            UPLOAD_FILE=3D$1
            shift
            ;;
        --version)
            echo "grab-boot-data.sh Version $VERSION"
            exit 0
            ;;
        --debug)
            set -x
            shift
            ;;
        *)
            echo "Unrecognized command line option '$1'"
            echo "Use -h for help"
            exit 1
            ;;
    esac
done

OUTFILE=3D"boot-data-${LAB}-${MACHINE}-$(timestamp).txt"
OUTPATH=3D${OUTPUT_DIR}/${OUTFILE}

# do some error checking
if [ -z "$SKIP_GRAB" -a "$LAB" =3D "unknown" ] ; then
    echo "Error: Please specify a lab name for the boot data"
    exit 1
fi

if [ -z "$SKIP_GRAB" -a "$MACHINE" =3D "unknown" ] ; then
    echo "Error: Please specify a machine name for the boot data"
    exit 1
fi

# check if 'quiet' and 'initcall_debug' are in the kernel command line
CMDLINE=3D"$(cat /proc/cmdline)"

if [ -z "$SKIP_CMDLINE_CHECKS" -a "${CMDLINE#*quiet}" =3D "${CMDLINE}" ] ; =
then
    echo "Error: Missing 'quiet' on kernel command line"
    echo "Please reboot the kernel with 'quiet' on the command line, and ru=
n again"
    exit 1
fi

if [ -z "$SKIP_CMDLINE_CHECKS" -a "${CMDLINE#*initcall_debug}" =3D "${CMDLI=
NE}" ] ; then
    echo "Error: Missing 'initcall_debug' on kernel command line"
    echo "Please reboot the kernel with 'initcall_debug' on the command lin=
e, and run again"
    exit 1
fi

out_section() {
    echo "=3D=3D $1 =3D=3D" >>$OUTPATH
    $2 >>$OUTPATH 2>&1
    echo >>$OUTPATH
}

get_config() {
    # check a few different places for the kernel config file
    if [ -f /proc/config.gz ] ; then
        zcat /proc/config.gz
        return
    fi

    # check /lib/modules
    RELEASE=3D"$(uname -r)"
    if [ -f /lib/modules/${RELEASE}/kernel/kernel/configs.ko ] ; then
        insmod /lib/modules/${RELEASE}/kernel/kernel/configs.ko
        zcat /proc/config.gz
        rmmod configs
        return
    fi
    if [ -f /lib/modules/${RELEASE}/kernel/kernel/configs.ko.xz ] ; then
        insmod /lib/modules/${RELEASE}/kernel/kernel/configs.ko.xz
        zcat /proc/config.gz
        rmmod configs
        return
    fi
    if [ -f /lib/modules/${RELEASE}/build/.config ] ; then
        cat /lib/modules/${RELEASE}/build/.config
        return
    fi

    # check /boot directory
    if [ -f /boot/config-${RELEASE} ] ; then
        cat /boot/config-${RELEASE}
        return
    fi
    if [ -f /boot/config ] ; then
        cat /boot/config
        return
    fi

    # other possibilities, though these are less likely on embedded devices
    # IMHO - it's too easy for these to be inaccurate, comment them
    # out for now
    # /usr/src/linux-$RELEASE/.config
    # /usr/src/linux/.config
    # /usr/lib/ostree-boot/config-$RELEASE
    # /usr/lib/kernel/config-$RELEASE
    # /usr/src/linux-headers-$RELEASE/.config",

    echo "Can't find kernel config data or file"
}

if [ -z "$SKIP_GRAB" ] ; then
    echo "=3D=3D=3D Machine Info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D" >$OUTPATH

    out_section UPTIME "uptime"

    echo "=3D=3D GRAB-BOOT-DATA INFO =3D=3D" >>$OUTPATH
    echo "GBD_ARGS=3D\"$SAVE_ARGS\"" >>$OUTPATH
    echo "GBD_VERSION=3D\"$VERSION\"" >>$OUTPATH
    echo >>$OUTPATH

    echo "=3D=3D Kernel Info =3D=3D" >>$OUTPATH
    echo "KERNEL_VERSION=3D\"$(uname -r -v)\"" >>$OUTPATH
    echo "KERNEL_CMDLINE=3D\"$CMDLINE\"" >>$OUTPATH
    echo >>$OUTPATH

    out_section OS "cat /etc/os-release"
    out_section MEMORY "free"
    out_section "DISK USAGE" "df -h"
    out_section MOUNTS "mount"
    # ps -A seems to work with procps ps, busybox ps, and toybox ps
    out_section PROCESSES "ps -A"
    #out_section INTERRUPTS "cat /proc/interrupts"
    out_section CORES "cat /proc/cpuinfo"
    out_section CONFIG "get_config"
    out_section "KERNEL MESSAGES" "dmesg"

    echo >>$OUTPATH

    echo "Boot data is in the file: $OUTPATH"
    UPLOAD_FILE=3D"${OUTPATH}"
fi

# should I also get a systemd-analyze here?

### upload the data
if [ -z "$SKIP_UPLOAD" ] ; then
    echo "Upload file=3D$UPLOAD_FILE"

    RESULT_HTML_FILE=3D"$(mktemp)"
    echo "Uploading data ..."
    curl -F submit_button=3DUpload -F file_1=3D@$UPLOAD_FILE -F file_2=3D -=
F file_3=3D $UPLOAD_URL -o $RESULT_HTML_FILE
    if grep "uploaded successfully" $RESULT_HTML_FILE >/dev/null 2>&1 ; the=
n
        echo "Data uploaded successfully."
        rm $RESULT_HTML_FILE
    else
        echo "Error: There was a problem uploading the data"
        echo "See $RESULT_HTML_FILE for details."
        echo "Don't forget to remove this file when done using it."
   fi
fi

