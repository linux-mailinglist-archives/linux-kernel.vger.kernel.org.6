Return-Path: <linux-kernel+bounces-195134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B158D480B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE461C240A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8B145B38;
	Thu, 30 May 2024 09:04:40 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA34D8C8
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059879; cv=fail; b=TOlTAe0u2AH6KT3AbshH+rMBPjEwhqPlL1a70ORpDyBONeibe8kB8jMdqMlct04HGH7efPYj/gyPQzznt1VD+BXjYGe6C/50ZUAxEnZniOyJ/lUrBFXd+nZY79yzaCI/JoGwwjeCjQ0TW7BJ5H5DanqjygcuF8HNl5GvUziW7qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059879; c=relaxed/simple;
	bh=a8MSOe+z4sdqJPN0vv1UMvih7/HG+Us+0WlkaELRuyg=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=uFoEh6OOLxAgVTyyB79VPzXQ4hbV+4SDY0/BYHfvTyUFEXd7ihMBJCXd+FCDVt0R32Nm2GdqwRFZIkwSeWNLIz1YIPmLazx7oNYQuOA1zYsxJcoRLurovTyBoL1RXVXsbJDZZlbMphLRU3tg+d3MBFp+nNChMmw9C93fAeiwgwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7nbSd006773;
	Thu, 30 May 2024 09:04:15 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3De8Q3zYxI8QSR?=
 =?UTF-8?Q?x2ybYrvgWlH7Sohxg2m4cBCjE/8mBmE=3D;_b=3DgFn1FAZpQC00S85V+88Ober?=
 =?UTF-8?Q?yk49Q0tGaPoUN28UzZrZCMMgVUMXDj1sEjmhJ9uzgk0MV_rxCImCZt9Q03A/bwJ?=
 =?UTF-8?Q?ZpkEtE3Wj4rjZR8o6wa9ZeGITB64QW9MVJACQ4VCpzSETCROESq_aom1hv7H03e?=
 =?UTF-8?Q?cg2KLEhByu0iHXMUApgYHHFV+6d2MuhPlRV2JDc8NJqq2L3x615QeVAAY_txCuz?=
 =?UTF-8?Q?LW9XtE0zJ2SvesFS6HBv7FwrUBKVODKHTRNFWgivyjqhNLfEKQKkF1ShuFHWymK?=
 =?UTF-8?Q?_5m/U1+9jGZAqKa39rhu8hTlUtT8CLrSMoYts9Xug2gxiruq6OwdbkEsWKLaNKC?=
 =?UTF-8?Q?6dRJJb_rw=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7rdx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:04:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U73A8W024142;
	Thu, 30 May 2024 09:04:13 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52dkkkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2KggK76jw8otRakmPNOnibS1uFAO2AM8+d/LAQr92pnJBeo2BsOilZWlFVZ8HjHB02MPXnaABZ89jHzZhEUGttIjK8j8VFV+BOaAHElHVzma+hXcRzZMn9/xixDexQVcHfymKtv/gth3XH3ldpGZETyUJsX5eWVAhCbkviFjKZ9oqBAss668EMeMSFDJ6jj0AaPr6LySRZ6ruezJcE0ONu2nVS1dW2JhKL2JZOwpXpQcZ79CNMYw31IXMhBIlZYQy5It+tudHZ4FqVM8doDkM/8BRpSai+ml+8Ab8jtNy8VkP+KiYn+uKKlYDZx4Kf3l8P9EeiC8BMICDFg+Je8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8Q3zYxI8QSRx2ybYrvgWlH7Sohxg2m4cBCjE/8mBmE=;
 b=BUCN6QbapdxEoYuDFMZ4PMJFYMRIQrdVrNeSSZaGLljPQW6xBNXJZ5P82cKf0J7P2Pn23iq69evmV4NMZe0/YGwoFhOn2KvU70LRFbhGb5OQ6u3AM0Pn+QEAIZJdaREFUGZcfDf8gMfunZctnfxftPYwVBTpQiAe3C/ddH/m7AQGT2xY8dEZA0C8KLMijfFQr+td+7EhfS2ExzI7n0O2p501jt/7V2H4GU+bCAQQswwisXStdbIDbnRhoawvht9Uv3ZNvI2hHD8x/eJd5WU4yLSTgpb9qz/Ab08e0M45pm64cEthHi+AWDUD1XE+35N7HHyDF0mmCUdPEYFY59cwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8Q3zYxI8QSRx2ybYrvgWlH7Sohxg2m4cBCjE/8mBmE=;
 b=shuV5cediG34EF9j84dFSxZ+TI1qxGNo5gUoni+M1VjHPGD0v0sAs8gSsJ1EHZW2wVsRskF0MBAmUGthZpVkrzgIEQ2/064DEWE2qh1tVXCdHNAVOozDKk4bGHBcqCm+eCnrPlwu7GENYdwfSYN4nRfvl1ShTWTEb+jsKa+BkKs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:04:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:04:10 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-10-ankur.a.arora@oracle.com>
 <20240528161316.GE26599@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, paulmck@kernel.org,
        rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
        joel@joelfernandes.org, raghavendra.kt@amd.com, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Paolo Bonzini
 <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 09/35] entry/kvm: handle lazy rescheduling at
 guest-entry
In-reply-to: <20240528161316.GE26599@noisy.programming.kicks-ass.net>
Date: Thu, 30 May 2024 02:04:02 -0700
Message-ID: <87jzjb7jst.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 154df3a5-a268-468c-51a8-08dc808777fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y8uZNUUG7kVROqXOpxBlqLrjdVSuWsblkX97IT3LZDymUjMb0VFAj4rPlYMd?=
 =?us-ascii?Q?VrSX9SLbQ5G+J+dS8zPjJHAq4BPN8OAGEY3S7MaFKYar6t2ITNbqtLFq3vUh?=
 =?us-ascii?Q?hctPz33wxcCHi3j9lJ+CAJVVkYe3JAeg3296y2IU5ZC8ruH+YL1caLxQUUU5?=
 =?us-ascii?Q?MP0kHFhpbSZJSNvQQta7WozSIjpUvac6urwu7QxNmbRAO8AP5nRRfK2jt2ce?=
 =?us-ascii?Q?ypQQ6TzCiiFUdrNU52UwA+3XdEoWiiilacrwGwF4CE6CTS1a2BdBTs1OiGjf?=
 =?us-ascii?Q?kl/KIcYH4NEbNvA2I/Gi92Puils2gReHFRfNa0OW+Mc0Ob0zoFTvCX8b7P+5?=
 =?us-ascii?Q?xD4UzGddqnNC4WTOORG3Nbp4NI3NtAYm3ZStdCx03ZiyUqleqFgBZmQUkhU9?=
 =?us-ascii?Q?4Pn4RQRwKqjTAgi92YCo6hLpSMZaggxytPyIpuGfUXfn34sa3+eygPSYMoZf?=
 =?us-ascii?Q?ARGzbbb8BtlHVuPYMkbcz5kcYfWDFZmKkwdHt5rPEd8sFpk0AV+juhfY5HXM?=
 =?us-ascii?Q?jeSP20shdKGWNaIQ0pcm2FzNIH8tHGp7fgYLtt/rJkT2ZU6z88zQ2hJjLyuV?=
 =?us-ascii?Q?oYJTZEih7q//x95wfBWOjC0hOU50duMef3Bk3eCWu2RPxfilP0N4bRa+hXNO?=
 =?us-ascii?Q?Tog5vKU6US7eoILdYtyLcXv75cv8LVyqa/ZoRv5FkEczjeWUoLK86Nj0O95b?=
 =?us-ascii?Q?cIXZJzvSdR7HbFNPD4EO4l0kBEOg9DJq+h40pCpfKEAt+shqSejxD+V+32+l?=
 =?us-ascii?Q?FEbPmr4xwaAfqkn/iBFa2KDwI9Bi5sC0aHLq0H2c9lqbnLjXvjyKKfbk6Fw7?=
 =?us-ascii?Q?MgVDaMra0F4k3BrG6q3v2zl+p/mPCmfTH3upjbbjGUkob3BqdAZMRgxFsUsy?=
 =?us-ascii?Q?l9+Ioms9InRlOA/CjAKcGK/LgOSm/EH+ootlfUk6W9sgv1rBqwPL+8W760HW?=
 =?us-ascii?Q?e+q19/RM48BEnbzJgOy3hSxnhvUgby1eOvFYrIuk0BZhFFCbHol9MkU5FKDN?=
 =?us-ascii?Q?Wvb7eNlFA9UN6Jk42FxFS1ZIx58DBqU3maJeVwHBfMuJD6gfTF65yEbL56ij?=
 =?us-ascii?Q?TGnBlmg35awcE4AS+XmvtMYMo8tJ7uJL9hifKrXnH0vDOsffLlHLA+eFdvDC?=
 =?us-ascii?Q?0CvrU3pOicTUq06fO2Ed+TCVxeqmm0F5y095BCFHBnYVPxm9A9DWQZVBOuxn?=
 =?us-ascii?Q?bI1aLyzpQUVDhuMy0+cJH+K9vMItueGEHcT7Lsy1jUHxc0WIzcR1b6g9WjM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oftGqJKYtNKzvMkfjqV6/bHwvJj47IQPT76OJBN0HtjCFSUQvrP7Q4z/jTrP?=
 =?us-ascii?Q?5kuQhblhLpOaqDc3lhc4oKB63cS9UHVqFlmwD7GvcDN+Uq3WciFN6ja7e3T9?=
 =?us-ascii?Q?Vl149jTWZ5jE3XTB9aLew0UiX05N56dFIWw4FYFhktYZIAyJJvKXHMRpj5I7?=
 =?us-ascii?Q?qp81pHSPcR4SuQ9sqcqWFn65pmxRswNKEOqcjozIrZh2x3n3FQ5jWoeQYiqq?=
 =?us-ascii?Q?1oK8SYUOPhpgULYGLT4hHRwG1jka0XtNcWNlCocTtPBxGYx7hB/Tu4JDMxVe?=
 =?us-ascii?Q?x0tRpFSjKJS9v/jISAD5oRUwvRANOnG9aviVPHe6+YUccBOME0azcSxd7QMK?=
 =?us-ascii?Q?7Ir1zeCKS6n2UOqZ1R6j294z+F6Bwd2pJyIveHyurIgjNXUDKyoIHgYj9++K?=
 =?us-ascii?Q?wv7DuaVoJnsLqGanD1GmNhAv1mSAKEnZOo++YaEdYMHXECkB1cM5EsHE90nB?=
 =?us-ascii?Q?tWR+mXojhDRltB+6efisfeOyTWg/qbzyx0LFO+i6YrFc/txj/9WjE47DSo7O?=
 =?us-ascii?Q?TKFZff+Op1nYa9hAwHYvBUCwJs2Rzgx9UTyjbfjcCDzvxtqiAgXWOawvwzjX?=
 =?us-ascii?Q?WEnxKHE0wqardhpEpinGMr7xWQcKjLW3a3gwm1Z0GOO8WwxnJhJPULanlD+b?=
 =?us-ascii?Q?p3jlhWBWgGB/h+V7tbjlUzcpwlUUX3qB++65J+MlPj6cX400AbYWaRz9oDdf?=
 =?us-ascii?Q?Ek2xyD+yBbK7XbeXxEaMmnk/6Rknzj/7CbmytWxCV80lfSZvoVGvTg+Gn1Tv?=
 =?us-ascii?Q?8sefsHRd0EKSLz+bVaJ5S0c8JVG+m5RK2rP8fI9Qk6fsqg2Qwoj0f+tryGaz?=
 =?us-ascii?Q?Fd14dQ7nB7ahUpqWdbk98XcMsIU3N/rSa4EwgMmcqh5uoYLQURE2Uf2Ipk/M?=
 =?us-ascii?Q?OgCPZFJrvR8vMUC2qQl1c8SMn/nmvDU6ACEPVIBXgPWXpBcaxsCOOvcsOACg?=
 =?us-ascii?Q?4DdWWWPxpxRFfa0/K20uggvCEcHzWkFI+ZiFjphko50diH/6DnWCjYhlhzQ3?=
 =?us-ascii?Q?qWMzujR0hVcCABmZm33LKrKjytNm6H/Vto4d0uXC96mXCsZwWh5+Bg+T8NMf?=
 =?us-ascii?Q?0yVNPRVQ8bhEDmC0ODm/th1RyJTwEHuwsEaUs5n9nrkJa5DN4o+t006GFJTA?=
 =?us-ascii?Q?BYgkPm/2OhjZWG1LyQ0adq4szvK87cYEpBHTdEDDkIAntYGM1sjzeJJORuMG?=
 =?us-ascii?Q?1KfYjo0rnUipuHzTp7+xCp8BQT8ThLX2685ZG1L/22x7ZuNa40OCH+Tt57xV?=
 =?us-ascii?Q?XMjApuPZyea8il2gVEei7DsraKUprrfLo1hFQ4+LKhGZWmmvt44KMT9/JaLA?=
 =?us-ascii?Q?8rTOX+15+PuTfRs5ftkuVuQXH1dl42JsKEzfPcXiOrHCiamIWjruzbbpg2uC?=
 =?us-ascii?Q?tmNhHo/K04yxMqjEOMoyrcVxUNt1T9HEu+bRvUU76Rg7yhpgal+SaUW3RLrn?=
 =?us-ascii?Q?e81aJLYgof2FsVlFtdgGCrbCOVAltzBsCv+UZrT2Jl0+3NPbz0zUZ735Uic0?=
 =?us-ascii?Q?35N01Lf4k7o7N4xeoLzHoAXR4m62eqota3UPPEIRUtOy/AGhFxQ+IcHnQcXC?=
 =?us-ascii?Q?JtL6swHBNEJizW9wsRBUSqw1CKEByHKHkIitziTvmeVOb+PezyB24aMfT/Cd?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+j61NAcz55pyhs2d+KYV9GadYMH8cQLRZ3YO3nGnTSWneHUUEyvKaNSvv66lACYcq2J67Jsc+vaC7iTuwVewkDJbHtNYtAftiQxRNGAydqWQWBssQrv1nyGa09pAx7ah97XGiyo3qL1SEQLYXpjcnGVkZNeMMM0ai2a/rVaLBbRkkFMHVuGEeOfNTyXAjroMsYtqRVHof6NCEBVInQdmGPn7YkX4Ijzf7OMG8TWPmjlRDcdkJY1AhZkO8/kFb8gBu4gVxrJQmZ3x3OyyhwUWiNlqoIuKSKUCUVStllT9B1/bJFq6x9njvkvDiLLz61FJDL4noDzgRRJ1qxSL8NtLD2787DsQlqkycm1AqC0oEcAMMUgtiTC15kPY0dqYrTb9A5F54AJRV5jPV1lr5KPZWT/9nF/mJ8C/QCLElJhqy7nIj7FacLiheTYZ7VlW4x7/4gjllVDjXOdZ0gZfCUmjs/YZtsRujwzgGFnH/d6T8I8yN9y1nvLNIoS+HUKqB1QW3VS5Yy/fWORseAFxb0ltF31GvCxBN1viaO4ci4i1tPH9C/IIxPGPhXjR3dpcV4z6pHz5Fpl3/4jX5/I9UJQwAUUmUYqvSYbTF5BSvVWOxX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154df3a5-a268-468c-51a8-08dc808777fc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:04:10.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZP7l6F4WzAMeVhQpeDH/ugRwXcIVo8eX39q6RXjdp+HzNnCaKhFtrcfWejPP3Q3vBhcgBUrFrHfCk6g/RAqDfcNPN3G7Gv8iWFiPPLihEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_06,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=770 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300067
X-Proofpoint-ORIG-GUID: f_WjORVGy9ys-IUMnSLtf-gvFQZBm4eH
X-Proofpoint-GUID: f_WjORVGy9ys-IUMnSLtf-gvFQZBm4eH


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 27, 2024 at 05:34:55PM -0700, Ankur Arora wrote:
>> Archs defining CONFIG_KVM_XFER_TO_GUEST_WORK call
>> xfer_to_guest_mode_handle_work() from various KVM vcpu-run
>> loops to check for any task work including rescheduling.
>>
>> Handle TIF_NEED_RESCHED_LAZY alongside TIF_NEED_RESCHED.
>>
>> Also, while at it, remove the explicit check for need_resched() in
>> the exit condition as that is already covered in the loop condition.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  include/linux/entry-kvm.h | 2 +-
>>  kernel/entry/kvm.c        | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
>> index 6813171afccb..674a622c91be 100644
>> --- a/include/linux/entry-kvm.h
>> +++ b/include/linux/entry-kvm.h
>> @@ -18,7 +18,7 @@
>>
>>  #define XFER_TO_GUEST_MODE_WORK						\
>>  	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
>> -	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
>> +	 _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED_LAZY | ARCH_XFER_TO_GUEST_MODE_WORK)
>
> Same as last patch, it seems weird to have both RESCHED flags so far
> apart.

True. Will fix this and the other.

--
ankur

