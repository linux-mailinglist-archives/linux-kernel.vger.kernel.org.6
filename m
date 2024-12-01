Return-Path: <linux-kernel+bounces-426714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B154D9DF6EF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 19:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3B4162C98
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3DD1D7E21;
	Sun,  1 Dec 2024 18:42:50 +0000 (UTC)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2127.outbound.protection.outlook.com [40.107.121.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1421B6555
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733078570; cv=fail; b=PsOUWiRs7LSkm+AqH8uR+Ivt7v02dj2bsY75znoPzaF/akxQK6aBDsHVRb+KziX6SMGCnFhCSj5PJH5Re6U5pW4tmsyxiTwDGNBj3LBQLkweirDL/7KAvRxsstsMhTqreHDUiZgyZr2DD7C+pFj46/nuHNvxgdDndezh9N+I65o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733078570; c=relaxed/simple;
	bh=yvKhjbAqPs55Pr9E82NoBc6liDyIXSVGMcYmurVjNsA=;
	h=Date:From:To:cc:Subject:Message-ID:Content-Type:MIME-Version; b=aU1KMVf8ol+XQ7J9zG+4S+uXqBrNAKl2gnE7L0e00nA2qfvUnyhjkYGvzTHD3ObgzHV0Mi8sAsjgQ+IepE4QFoUKh6z9DLzFkyB99ZhHuAU6JQlUyotSX9jsBV4Y2AqV7ux9h+MI0rd688qus50Jhq1ofh24Uy2zTyQaTW5oCzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.121.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbSEOyFsUOq0SeCKBOHfA5xeSfYeRsYn1oxUBXB5PKcoCmkq9M0CgVV70pMX6iVoJ7qieMjtJnWNsjktd+CvQ7E1MFrb6B1FFodc+KBcwsjlZpTtjf/Gr88lTiCwnfZgGeh+j18SZ9x6ILfntHbovOF9msq4Bi5qkQ+n72Po2NSa0zszH+ggPQguFhA/+BE4C9CO+47dXYVxf3pt4xoY/z2yk5Fl0vcUfj1nU68rm7bd6WCEr4NE3dLNOPnejGgl9deOorwe7sS1klTlcOo8GtwRoG3rdPBTLKcAgsV5D9W6PAgFia1trQyuUwZVQ+BKU6GOjkgZj2ik2xLFxRBRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiM89hQKvGKaN3yCD9PeTvOwkEh6TOpaDyi9vAvFW2o=;
 b=kEV7M7Yk8ZupDfN1T4TPu45Jp5050/Ncc0qY4zdTpjffVpimXN+ZMF5Tpz+cNe6Xj66hSijo8200qgR/PZsvBpp0ShhjMeDea3C6lJKOSaq+f9UHwpLvV4qglarYJ5uRRD0Ukhp8wcksvc3qrlSaHizonGSxP9uoa5IaJ6k6jXgtsSe8Q9be8hlKoxKjPRrjj/oKH5QMHMKgex4mfrwrYEqIkLggVfwE4Nns7D5g1LYDJ5eC1Xi2Q5ZSdhrdcmKRtUwMonOuQZzglchG/eg7oXelJd04J+7ZFEPWbhEyyktskmPkquBYq00yEu+CpIs4C1orZkyJNRmqBIPGT2OSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB7148.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:32f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 18:42:45 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%5]) with mapi id 15.20.8207.017; Sun, 1 Dec 2024
 18:42:45 +0000
Date: Sun, 1 Dec 2024 18:42:44 +0000 (GMT)
From: Aaron Tomlin <atomlin@atomlin.com>
To: oleg@redhat.com, frederic@kernel.org, peterz@infradead.org
cc: atomlin@atomlin.com, nick.lange@gmail.com, seun.ewulomi@gmail.com, 
    linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] sched/isolation: Warn when maxcpus= is specified
 with nohz_full= or isolcpus=
Message-ID: <b51c2515-8cbc-ac7e-97ea-c6fd0e07cad6@atomlin.com>
Content-Type: multipart/mixed; boundary="-1463799552-1067086594-1733078564=:8619"
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d7c938-1d76-4c5b-9780-08dd1237f1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+OYGVzO7mvV2t/kTkVVROpfgx/dPGlzsE1cAYsSmMQa9Mh5sJA/QPBKz4Jzg?=
 =?us-ascii?Q?ajh5jHkC0cGnFxiVh7PL4pWO9dQCbq2ukgrbQjdCbgfLwxRl6vCx0bKl9IE/?=
 =?us-ascii?Q?7DGs2+Xk3ASXzjGkNoIf9sGl+CGh5vCwcWQm2cB2NkNNK3Dtv9QxKC8XswQQ?=
 =?us-ascii?Q?nJnuHV9PMrTfvfvCFFA56BwVTYoQfBZHtndwRs4ggPddJGsHD1SS6kWQOEqL?=
 =?us-ascii?Q?dAr1D/ud9LkWymcWT7WMjYDRKZ8S8Wd+iAUOJuWjx6/bIvyB+g1inaqkXZnf?=
 =?us-ascii?Q?MlbqpNeCSDK2DcueZs1kdU+FOn9XqKh9Ciom2vxsXWdpnhoHdnMqy9abhMSc?=
 =?us-ascii?Q?iNJlPEFyEIIqha7YsN4Z3rA5dr6K1Z5xdvgsegyEGe5STz/QLrZipZZRAleJ?=
 =?us-ascii?Q?RigLbmdAGdJ284QHvI8pG/HEOIZHYeNR/elnv4ljf1uj4vsnXTPa6Ct+AhiN?=
 =?us-ascii?Q?U9ZvPOHJp39QD1Tj1nZLJivjrgqiw1LFMfWAb77bsSEcQ6482bo6ryaEXyeM?=
 =?us-ascii?Q?1miRcHpRnY/NZiAi7pM0AbLfiqj4WV/+ZNkzW9Zbj7SQ3zF6C93S617tx+mG?=
 =?us-ascii?Q?sCCCgNtUeE/KgcYWveW3MXqd1KlnpivAEJ/8SyZA+OwPlRMgPkUUAhPa7y6O?=
 =?us-ascii?Q?gQ3gDwoPoqX4hG9LS3+Vd11KmXOUaeWfD4U2+iIvT/+tFG2i0oUANwQjKspP?=
 =?us-ascii?Q?46BrxQB0QUVxrz2TEIzXOgzrzpxmoaQulZAKgdYjCWDyob5uJxjXpk3bplpi?=
 =?us-ascii?Q?yfyz2zKc8DSXHhiYaPpK6d++PgKQoFA8N+VsNrnvranljqp+5TrET0N9oRkF?=
 =?us-ascii?Q?uinzeekImrDTDMbkTVt89uhlh/psTU4ORWzzLvNX8nDfpJvxOy0vunh/8gFD?=
 =?us-ascii?Q?tKtBXZ/1pW11AhOhckNoqFIuEoWGf6/EM+oE8HqD4+q9RnWefnyQiiTHcL6h?=
 =?us-ascii?Q?Gd8olI7TeoPi5Y/FCS35tMBq0CIHFsGVb6nIs1pne0qjJNfI1HPFs0KLMfh1?=
 =?us-ascii?Q?ncwW0zfXqDcIkMYLdTCseQUBIUd5kHOSRnL+vpXL+OnKJsGRAkLAmDTXO7LM?=
 =?us-ascii?Q?d9ivWL26kvgmyQnQeVIpAmrRdZDMxomi0XH65nz9zHg5/5n49AhqjLJWlMDf?=
 =?us-ascii?Q?3Q4sGeSa7Ck1cmJmluAcoNhGEiKBOpfcFV4QZDMYl1BKfMCbc0tsHgBV4biY?=
 =?us-ascii?Q?3rgHhLd8EwoXD14x0JWLYgka+fFWf4J3g+xytEeeTICMdr2lirOCwriNa4dd?=
 =?us-ascii?Q?5dd2FAyONtKuyxcN5CGC2iFbav2D8p2U3KQ+4ZhY/4CM397mqpqL5PSf/yON?=
 =?us-ascii?Q?YwsBEJiHNROYvhxB3xgtBK/m18NVfDoLCHfzN1MdAgF/lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MVhQ+AOo4cjfcwVhsqnJwSOoDwC2C4no63hEP11VE+LmgCcfIW+MHDxbnOx0?=
 =?us-ascii?Q?IRAxFKaLljWLdubX00xQcy8tF1LnsKDhbUkL+2Pv4FhwbjUS8YpbknokJRXP?=
 =?us-ascii?Q?PZ2HV5QtPdVXr/VzLxkuhybaVWVtecTmt9zkehdcXboHHiUz+IS5OohXtaaS?=
 =?us-ascii?Q?jYMk8BdcvYCZa0p7uOuw0VFXZVEeTGCC+QVJzA43M1K0dCIzLvQjHqvYCQOG?=
 =?us-ascii?Q?HqwPw6NJqGW9rMMglkJR5eg3Eik6cDtiM2DK4+YeHV4xFbZCDEt7Yv2uz9E1?=
 =?us-ascii?Q?k1e51to4fcuc/fG7cdwOspR//F3xPK9Y+JXT45sbGbY92+5L+m70rYdiTXIj?=
 =?us-ascii?Q?aF9ys3whAYeDpXatqxKXLd0F6L95KLNAGKLI17yPX9mn8GvN0xPDwz8sHm23?=
 =?us-ascii?Q?ezxT6626kDt25k9d6A6hIV0qYG7fuOcQy8+HspK+4dAs3xmJBaRG2Vxnx/N7?=
 =?us-ascii?Q?THqYsnFz9sc7S6M43v8j0p0FwMeoLgk7hNfBS/KbVjETjdwdHlK41f/h+tDH?=
 =?us-ascii?Q?YVCEUWVxbKLPLdMwiGQpyDtgpse2jMF1PzVSfkSLl0kK8sxvRMIl13h0aYA8?=
 =?us-ascii?Q?mCjb1f0rf7W4soTv2wmONryEOWi+LURqEOAllCND8hI2+3/nJ8mtK6hOA7gg?=
 =?us-ascii?Q?Pm4WlbrwkZ+mKljHZMcd3XQ8S0ygQpDRaKz2A7w23zkcxfWhCfRvDE9QmxGr?=
 =?us-ascii?Q?yaTNe7MJ6vKueP+Ezi6dITpROK8bkIvPNPvkj82NRFaqABx6D6BSQhOyPaUe?=
 =?us-ascii?Q?u42+ds8yW4XaITLVHEcMAPL1CtHE29r8OZRke8UMSWVpWGnUEd2DqCUIq6i1?=
 =?us-ascii?Q?CmKnoC77kuhw5Fw+HAJJusYeoV68XqcagBMoAQmAECw3yhuwy3Ub7ehhR2m+?=
 =?us-ascii?Q?uo4n0Xiy/C3X/Hx1XNIN6ybYqj0h/A0v3a54U/Km8sQUHe6QAN+VBkOxa4se?=
 =?us-ascii?Q?P9R6Qw0gCy7gFE1zlnrGTOwtEsMtEHOcg8JnTlWEP4IyHpYi6Fvf9UL91+Kx?=
 =?us-ascii?Q?chJVuqnPSD8yQ148cAVItYcAoqP1qfQ8Aiwr/s7lX/LQ6oAmip7W+7kXiDDQ?=
 =?us-ascii?Q?ALmN6XXlOh/OMSMobzRfozgx86u3ubVCKZNdmMtuXU5mZTEY1HuMuvfskI/q?=
 =?us-ascii?Q?BsGNL7L+T3Jsv25Y1rzInqnrLG7eOXQGpezkKJmrqn1l3C06Ad405egkap/C?=
 =?us-ascii?Q?J23xkq+GxeURTaA9MJQgsNksrL1A2WAkImFIKLXcxHbjqjbe5btt37+gLhHK?=
 =?us-ascii?Q?EyzqYg20AJ7hjKsux/w35HDHEU1FyrzIIHRb4RfbnwcBAdR96SGRg+25cAgk?=
 =?us-ascii?Q?VkpZzE/K6Oyk0fCQ7lFJStkLGIMtavW/N1zxhXpYUJ8yhJlLTsG16zdmnHq9?=
 =?us-ascii?Q?nqdfAUztxGjinFVLaOoSf2ViQrXIKazsFastf8rAJ7a+rgHhphklEhtODi0O?=
 =?us-ascii?Q?tR8/PQydJoQFfYNDSxWxf49BzI8q0Dh5at0SsCaI/PNKuW1aQyITX4RFhHMx?=
 =?us-ascii?Q?dwf51vs+iE9SsxRwbt3M+vACk3IjHQGVxjboV4pv/1Rati1yORfb+pXKJzWL?=
 =?us-ascii?Q?aKhZ7sa8L31RZrzzsuq2ew0BRaddUQ2xqcWycJnv?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d7c938-1d76-4c5b-9780-08dd1237f1d6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 18:42:44.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm74xYhY6h2Af2QJRD3x3mXX7tUPIjAfJ+eNMa+JQQRU6UKn5Scg5/lYmqN5+4AVtZ6i6/dHBeleyRYVf0sskw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7148

---1463799552-1067086594-1733078564=:8619
Content-Type: text/plain; charset=US-ASCII

Hi Oleg, Frederic, Peter,

I have seen a case where maxcpus=1 and e.g. nohz_full=1,3-31, was used to
force the CPU affinity of certain unbound or non CPU-specific kernel
threads at boot-time. Albeit, since commit 9cc5b8656892a ("isolcpus: Affine
unbound kernel threads to housekeeping cpus") this is handled entirely via
nohz_full=. I thought it might be worth adding a warning.


Aaron Tomlin (1):
  sched/isolation: Warn when maxcpus= is specified with nohz_full= or
    isolcpus=

 kernel/sched/isolation.c | 2 ++
 1 file changed, 2 insertions(+)

--
2.47.1

-- 
Aaron Tomlin
---1463799552-1067086594-1733078564=:8619
Content-Type: text/plain; charset=US-ASCII; name=0001-sched-isolation-Warn-when-maxcpus-is-specified-with-.patch
Content-Transfer-Encoding: BASE64
Content-ID: <c88c4935-ed9a-dd6e-2664-913b8cb88936@atomlin.usersys.com>
Content-Description:
Content-Disposition: attachment; filename=0001-sched-isolation-Warn-when-maxcpus-is-specified-with-.patch

RnJvbSA5ZDgyZWI5ZjljMDAxMDAyNTA0N2M0NTc1NGVjODFjMzgzMjU0N2U0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogQWFyb24gVG9tbGluIDxhdG9tbGluQGF0b21saW4uY29tPg0K
RGF0ZTogU2F0LCAzMCBOb3YgMjAyNCAyMzozMTozOSArMDAwMA0KU3ViamVjdDogW1JGQyBQQVRD
SCAxLzFdIHNjaGVkL2lzb2xhdGlvbjogV2FybiB3aGVuIG1heGNwdXM9IGlzIHNwZWNpZmllZCB3
aXRoDQogbm9oel9mdWxsPSBvciBpc29sY3B1cz0NCg0KSW4gdGhlIGNvbnRleHQgb2YgaG91c2Vr
ZWVwaW5nX3NldHVwKCksIHRoZSB1c2Ugb2YgbWF4Y3B1cz0gZG9lcyBub3QNCmRpY3RhdGUgaG93
IHRoZSBob3VzZWtlZXBpbmcgQ1BVIG1hc2sgaXMgYnVpbHQgaS5lLiBvbmx5IHRoZSAicG9zc2li
bGUiDQpDUFUgbWFzayBhbmQgbm9uLWhvdXNla2VlcGluZyBDUFUgbWFzayBpcyBjb25zaWRlcmVk
LiBJbmRlZWQgdGhlDQpwb3NzaWJsZSBDUFUgbWFzayBpcyBpbmRpY2F0aXZlIG9mIHRoZSBDUFUo
cykgdGhhdCBjYW4gYmUgYnJvdWdodCBvbmxpbmUNCmlmIHRoZXkgYXJlIHBoeXNpY2FsIHByZXNl
bnQuDQoNClNvbWUgY3VzdG9tZXJzIGluIHRoZSBwYXN0IGhhdmUgdXNlZCBtYXhjcHVzPTEgZS5n
LiB3aXRoDQpub2h6X2Z1bGw9MSwzLTMxLCB0byBmb3JjZSB0aGUgQ1BVIGFmZmluaXR5IG9mIGNl
cnRhaW4gdW5ib3VuZCBvciBub24NCkNQVS1zcGVjaWZpYyBrZXJuZWwgdGhyZWFkcyBhdCBib290
LXRpbWUuIEFsYmVpdCwgc2luY2UgY29tbWl0DQo5Y2M1Yjg2NTY4OTJhICgiaXNvbGNwdXM6IEFm
ZmluZSB1bmJvdW5kIGtlcm5lbCB0aHJlYWRzIHRvIGhvdXNla2VlcGluZw0KY3B1cyIpIHRoaXMg
aXMgaGFuZGxlZCBlbnRpcmVseSB2aWEgbm9oel9mdWxsPS4NCg0KVGhpcyBwYXRjaCBhZGRzIGEg
c2ltcGxlIHdhcm5pbmcgd2hlbiBtYXhjcHVzPSBhbmQgbm9oel9mdWxsPSBvcg0KaXNvbGNwdXM9
IGlzIHNwZWNpZmllZC4gSG93ZXZlciwgc2luY2UgY29tbWl0IDI1N2JmODlkODQxMjENCigic2No
ZWQvaXNvbGF0aW9uOiBGaXggYm9vdCBjcmFzaCB3aGVuIG1heGNwdXMgPCBmaXJzdCBob3VzZWtl
ZXBpbmcNCkNQVSIpIG1heGNwdXM9MSBhbmQgYW4gdW5zdWl0YWJsZSBub2h6X2Z1bGw9IHJlYWRp
bmcgaXMgaGFuZGxlZA0KYXBwcm9wcmlhdGVseSBub3cuDQoNClNpZ25lZC1vZmYtYnk6IEFhcm9u
IFRvbWxpbiA8YXRvbWxpbkBhdG9tbGluLmNvbT4NCi0tLQ0KIGtlcm5lbC9zY2hlZC9pc29sYXRp
b24uYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9rZXJuZWwvc2NoZWQvaXNvbGF0aW9uLmMgYi9rZXJuZWwvc2NoZWQvaXNvbGF0aW9uLmMN
CmluZGV4IDU4OTFlNzE1ZjAwZC4uMjdjZGM3MTFkY2Y1IDEwMDY0NA0KLS0tIGEva2VybmVsL3Nj
aGVkL2lzb2xhdGlvbi5jDQorKysgYi9rZXJuZWwvc2NoZWQvaXNvbGF0aW9uLmMNCkBAIC0xMzgs
NiArMTM4LDggQEAgc3RhdGljIGludCBfX2luaXQgaG91c2VrZWVwaW5nX3NldHVwKGNoYXIgKnN0
ciwgdW5zaWduZWQgbG9uZyBmbGFncykNCiAJYWxsb2NfYm9vdG1lbV9jcHVtYXNrX3ZhcigmaG91
c2VrZWVwaW5nX3N0YWdpbmcpOw0KIAljcHVtYXNrX2FuZG5vdChob3VzZWtlZXBpbmdfc3RhZ2lu
ZywNCiAJCSAgICAgICBjcHVfcG9zc2libGVfbWFzaywgbm9uX2hvdXNla2VlcGluZ19tYXNrKTsN
CisJaWYgKHNldHVwX21heF9jcHVzICE9IE5SX0NQVVMpDQorCQlwcl93YXJuKCJIb3VzZWtlZXBp
bmc6IG1heGNwdXM9IGhhcyBiZWVuIHNwZWNpZmllZCB0b29cbiIpOw0KIA0KIAlmaXJzdF9jcHUg
PSBjcHVtYXNrX2ZpcnN0X2FuZChjcHVfcHJlc2VudF9tYXNrLCBob3VzZWtlZXBpbmdfc3RhZ2lu
Zyk7DQogCWlmIChmaXJzdF9jcHUgPj0gbnJfY3B1X2lkcyB8fCBmaXJzdF9jcHUgPj0gc2V0dXBf
bWF4X2NwdXMpIHsNCi0tIA0KMi40Ny4xDQoNCg==

---1463799552-1067086594-1733078564=:8619--

