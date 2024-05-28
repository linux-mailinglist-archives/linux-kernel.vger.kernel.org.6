Return-Path: <linux-kernel+bounces-191557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ABA8D10F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1180F1F21007
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D763CF58;
	Tue, 28 May 2024 00:36:27 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62684DDC3
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856585; cv=fail; b=t+0rzRG4ggQBrHXRmEpGa1WIGTOi4GzlJ4I/YyKpghzVOSZ9BbS0H8tScdhneCm/aVoar7WgvcW5A9gsVZzJrpNIqtKeEwXSSoOYAlu5HYa6GkUfKCAVeyprw680ieHGjbikfpqmfi86nOJJ94blWD+il2rDsDRNpPxhAt/bwUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856585; c=relaxed/simple;
	bh=CGGqpTc4XjWy8ugmVZnmmyrSzYDMv9RuWhE8WpPwdn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ngtUCIpRWGujSTOSflwPYJF8ZK7WCS1SgVLZ1MH0KHL7ZVj/VuEEOpFgl/CXks3ZMXhR7yHbic5XxeZxO6Ko5B4w4BZYRvXte1JEcFmK0+NC+ZYhy1XO/+RPwB9QoL0MLTuXcnSnKi/wFxRYwkfcDKEVQDCLxxaBUc39JDmq+FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RH4gxs001280;
	Tue, 28 May 2024 00:36:08 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D0iFcjpALK5ExneZIccLZ3bDCRkqSscI3NMVdDFB/72w=3D;_b?=
 =?UTF-8?Q?=3DDyHHE1P3tQYGkVWnnwxYfV6AUfefrALEzRu5VTFop1iAhJFCTf8EbMGszLGK?=
 =?UTF-8?Q?MqsOd6Q2_UGpi2hWmZcK32i+7zXjvJmnUCmCHDY7u6w6tPDnDx7c5leAVkoiuqI?=
 =?UTF-8?Q?zdA9TLDpW0ccc/_tee6mv5JTgoWNLEa9bYYcLaAKUuwlyjSo4Ok/fQ6kMD8E5mV?=
 =?UTF-8?Q?0YMMaDjVNfHVuXmPem42_f705Yy+fA3AB/nwnUhW2NC0JCNo/JhJzha4Y9u0Egx?=
 =?UTF-8?Q?OdBpHrLB8KsY3f9uduZJz9oqgA_CspOkxq+5IdItDetKVUUh1vXRi+8rSp1zfUA?=
 =?UTF-8?Q?HGuC6Dyoaj4YXoI75kTOYKAGIcshECOw_JQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9k8w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RL6qBw036572;
	Tue, 28 May 2024 00:36:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc534rdfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTz/WkIqhKGXLDftzQP42SzPZHw1MH1zcx+b1//HWcCeD2ABTftDVEd2nYM5Sn3zCl638lgwNzk35mU6l98SvgiKwuMhvkDrHTXJ3vCtrpKkiv4BQuTZLNGLl1+FsI1ZYlE0XqjpFK3+GLeIJwmROB+wMn9X4uQ3nk16i2hqwlmoRLvqay4PlddYtqItPG1cJUXAQfbewqvhDrbrBvziR/T06/AocJLQFOAMfDBRorQd6DQeq/aCnXG2ZWcM0qVya7KS+OxtbXQuYiaOCpFTsWeVQM+EBbz69p+/x/Z3iT6AhEvN5T8uKmLFYmXdeYRxp/4P6ilfZEA5FW8qXgfBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iFcjpALK5ExneZIccLZ3bDCRkqSscI3NMVdDFB/72w=;
 b=XLxkJ7IZ9sHDvsCXEX5Ad/ehQ2hA7ALhG1QvDbzIfkMEXUGZbD7kjRd9hmhwUnQR02B2Hfq1iE69tFTfhE2/0rU8dIwLxc19RG8pjniVvGgRxZ4F6ofiJWgz6FAfRtt64UHofL7ZiBg3UVvZTIPHBEVG0K2c4eEzrZGoVvMFxWvt3EBzeXIDyX6h+u65B/HUMmBUGBmJ36s/sbeNcL8JHMnoxjGHxaY8PPDxHxsMHul8lrNWhGtxuqe7MIaNR0nJKyX12gKPX2xtO3vKK608h/NDexLOgpLYQQzwTRm7DFTCM5JDpD0C7rgFg3XO97aU/D/ddvJpNTwIbD701Hldaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iFcjpALK5ExneZIccLZ3bDCRkqSscI3NMVdDFB/72w=;
 b=GT/iogFj752CWz4Nw6cPSBFgj6KH6+9A5bqFjoxVift3295D8eq+UrfdxLHb9RqhFALtmDyTVh5+vPSWKZXWnaRq7KGfb96scJm/h4hD8P1u11PMqZNetRxbeRDdqatO/InkmB6BOZpzqxcspJKlPN+0HXnNE0pqM4VyDNfde00=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:05 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 12/35] sched: separate PREEMPT_DYNAMIC config logic
Date: Mon, 27 May 2024 17:34:58 -0700
Message-Id: <20240528003521.979836-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:303:2a::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fa83bb-1c78-499f-9955-08dc7eae28c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?D1tJ/1OGOy4d3BMhJQ7x3Y4kE+LbAaXCDG2+ilUWQZ7Za44bhh1PQc8EOFtZ?=
 =?us-ascii?Q?NCjYi23oDvrdqFAE0HhEle4Qmgh/Ut/8ZDybj8oHM91WDMyDxITtttJTyLR3?=
 =?us-ascii?Q?cBL2cgyqt20z+dZuh7Gqtr4+5BeJjiczbnH9hKGMQ/P9T3RhlwJcF/W814XP?=
 =?us-ascii?Q?14RxYXc5KA3sl6TBUvRvJGzGHrhM3OI9Ib+Gsc0MzCZ8RxVvBbsZNj5p1fde?=
 =?us-ascii?Q?QXDGrf05anEEjD+eiCqMY5E8D8s3zVMukG/DpOb1oNw66EBbeuI2Z0A+sQcD?=
 =?us-ascii?Q?jj3AYTHE+hU+u491fwoJ1//DNtPv3/ZCwaMcPCD+k1NxqOn2NANob+UiOOcm?=
 =?us-ascii?Q?JYABEdxalO40LVPJOsyp4LS4S+ttKY4lvJnPVqWpqhm/SL0G3xbCRoPkIcta?=
 =?us-ascii?Q?vGy3MxtNB1KukG6U63unzLkoS0H446dMzjwlwoTDxsx715qWo7dFMCHeFEvo?=
 =?us-ascii?Q?Z29Muon3+GQZCQKxxqM2r/We8/QPNusYH9ZTL5Bgszx73+d+Xs2vo9k+Uycb?=
 =?us-ascii?Q?DeQNihghD4g/HdPz4Ji9cYGs8b13T87c9ZVtfrHm52tmG6EwuweIfQBzbKpA?=
 =?us-ascii?Q?I9j1Lrxmnm258AP2msLPMlWbVdgIo6D5nW5aJH7wtCe8IXbodarly19A1iwF?=
 =?us-ascii?Q?Bg4RgJUMxIaBDst55lzprsl7gXvbPzAKIa5Etp/pfIWhpgCkBTlemubmsHid?=
 =?us-ascii?Q?ux90OOi2eliI+xcpkeDXOyTnBptjirb1kIWzCSX+HlSXUzX8b7+98y4qIS3l?=
 =?us-ascii?Q?8EI6s0o2monkq/hh5XFEqvBKRuJv99egvVe7+CCDb4rIPtUOFezcut6C451e?=
 =?us-ascii?Q?CjqtxNikvdiaJM8bQ9lFkEVOkWGNOYtomw4KVrvLnPjtGr6YuBhIzu9JZn9O?=
 =?us-ascii?Q?JWtrYgq6JMQ5FMdhWd5FKP01tmD0ggUSUQoDcdobEYJJWKE6Afwm2MNeJIlB?=
 =?us-ascii?Q?uTtW0DaLrxW6m3OuMt6S3rFmduDyjDeHiUJIHWLU+Gck748mptIfo4XidEnd?=
 =?us-ascii?Q?3DbyBpQD3HiZCBsZwr1uSWtmJagnddQpFwuvzXBFNs9vfklRk8sUImTjZ/0o?=
 =?us-ascii?Q?LyLDMvFv0PKOoNuk7TpZ9RGN4hJDvO+7nSmIOCGErl4/BNXmCpplIQdsEM3L?=
 =?us-ascii?Q?02tx1rQAO7G3xVPSWMBhQ9A1suGhM0jJeyqEMoH7Zf2VvKxQGt4Yz+6PN8fi?=
 =?us-ascii?Q?Fnhz9iC98Th6Gf3RW861k0WD/8emOJ2UvW0EIDFwfcAws/PCn6zwwFsCdypD?=
 =?us-ascii?Q?oXtQkfduhk6EpsnOAE1S6947V3J2oYj4p37EryIgxw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rU8UNe5NDOCawAUe2UiBxRyJCCEq75NoJg7HTeLloT4kS4YOUfuMolKZe2QT?=
 =?us-ascii?Q?vHNFgL4kgDjZJEbwrqrUtJsYSMoOMTCgpIvA6ClBAXlgVsGiau3MUEL8iuJP?=
 =?us-ascii?Q?7vfio2tz1zREpIaL2sKLm4sg/O6TiIWqjZ7c6yNtBnCVbMBOuWcoq740EDJg?=
 =?us-ascii?Q?WxkqP5askRdV+64mxUqGvuVtGV7IXwDT4rYAeLqSsnXoh39SJXsUwdDAyBYB?=
 =?us-ascii?Q?UxYgUQbIQiHXBYrG9st0GAJZJo6gQMuPsReSw5BxxABFqtL1MPQltKYQ+AC5?=
 =?us-ascii?Q?fqbl1HVjJ03z7DYXhWkS2BZzDJaHE5ZfxMP0LuEsxySP7B9VQduWgC5wN6kb?=
 =?us-ascii?Q?7F6bEi0Eh4DvCZ4xD4CZUJnOnj3dIoaB5uorA/ECLa93yWfBDI3GGi1O/dls?=
 =?us-ascii?Q?0jxW3ZHsUiRH5NgctCPsm8N7l56XxvUTvIbxgfAd7kzHnoVK6fuubye4VqGy?=
 =?us-ascii?Q?zOBXYLsZ0ILHWJwotI7TqgWpPFPN4jSAmjPCb99ZXhwGwVmJzSMv1K8B820E?=
 =?us-ascii?Q?wYg1aHuPyIkhzaRPH9VHsWsUNpZGUNQx7HD0nOp+tOSi/dmOinl5DPh3XJJx?=
 =?us-ascii?Q?ym9lBFN4zdr6aELygBfJ6Q3w2bqi+Xp/yEUn+ObNBhAY7GPNV/lis/ieZA0M?=
 =?us-ascii?Q?m+B9cnstXExVM3v9EcAd5pLuKvEM45JF5EaJwsYbwjLiA1HE2VOZHjfgj2m+?=
 =?us-ascii?Q?lWI7Q9f3JDVTIzYI5dtY80EW33ZD23tFjB/lc/8K9lcJy3hYJ9MqlUEnKCsh?=
 =?us-ascii?Q?ZaR8Ag1K6OJQliD6VWl0Bq6V8PikvSbbEXGcj76+MIpJvQ+A8hYk23roGMGb?=
 =?us-ascii?Q?X1yYBd9GuFORDhSptqVntxApi0lONBHZBlBH0XVW5hfcj2eC8S0g4yzW5GNn?=
 =?us-ascii?Q?JDZs90q1zID5rFtoUcCHrG1X+N0lIVUBTEE+1PAWJU65ftjVwUdl9u3qw7iR?=
 =?us-ascii?Q?wZM6lpDxn8VJ62jCH7ZqROxGFpEU95hgLql+YrJJiRglNVs4YSUyouKV1D5X?=
 =?us-ascii?Q?IUEuOae4fxE7sm4JlOyk2F3qaHG649rrh1/CUeiKmf6tzQ3TbM+Ov5yqOX5J?=
 =?us-ascii?Q?9mETQr29KCXstP2B4E8M3cY+/jR36cJtaRPJk9bWU893YD9Rsta5MZ8mpolL?=
 =?us-ascii?Q?igFNkV7N9tlrTjacJTT1Mu4I2WBxdjUYVozYfKRbv0tml/vP0H5mWfEEVprD?=
 =?us-ascii?Q?JpgOTSCve+qYvw+kT8T8fQgdhsgAhH2QOdJJHZNKLd2TeWrkK4DaI9G8rNuh?=
 =?us-ascii?Q?6WLSBkA6MTwcrK6/cTSTQJ11j/SR43A6MA95Fl7yh1xzo/xVgEXrR2sShCpS?=
 =?us-ascii?Q?3BrozNtOml77KT1uPJM7ZFR7CQPwdEkznxmOZoq/+PXJyHs7TDSJvGhGbJkW?=
 =?us-ascii?Q?w0zp5biSKPG1AvPDDeh08UiPcTGTcxV37KAWXBgZQyJo8iwQBoLMpNs4siam?=
 =?us-ascii?Q?qzsRmFRQYcHjhKUZOtfRLpv5ie97MVmMq6hlTLMV9MmA0wpxBcIuxk0z4L7Z?=
 =?us-ascii?Q?MbHgW0d8WtOu8oEpKuwcgQnb1y4kRB8ARPjx9sJWc4d3E79Ua/WNu6VnA38G?=
 =?us-ascii?Q?VOjMxinisvmrmf5qAARg3nlcCH+OUa4zCKEg27q6dVh+LrzFKjGmT8fcm0JO?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+Gk1BdfsQaSqaZi/Bb5bD+oF0JyCTiUlcMJxudXPMAfRbSvEtBsScMshZIUQDu7RB+8n50KOHCLuISG4bZOsVKCHwf2YAHq7yQkOgtyTmLXMVNPTupOcCvBKcnrzRNNNj6UB8DOxdtfF775VJVDmQFN4sFCC37PlCvgexRhwP+y39LwI/j2rXGPhsvZrEp8SCXdRr2jQpFiYtl+oXC2yEt9RwR0XFF7f5qHZEXUr3XyQrdeuf9+HXn6WQdgNfwVNFM9vmJj0JqQoY+9lR6krn2+KerYg3lzQUrXl3zIv1MEcLmWmO95zHoFN7JB7tBWmvUhDtbWYGHwluRONq7HvwdVuRgqckJHrPRS4oBNjAIDrM4hTepWktkBkxvn5lEMBYDwUoH62lJLAr/l+ztoY2WssO58Kl4RM5tGm2/rGcjsUaFVd7iJeJ5jMY2FZu1JRj6OqnhdEvMd1KGK9YtTgxJZhfeY3aWGtIktkN8gAnDJ/IjP6LFxkP6kWg2nuh7Le6k11A2nyBqvkC+nd4JOxsLu03KofEIXGhIjbj3hdl8pB2zRL2BjH9OZ0TafF7KShCwsrEsMzza5gJ307hSw0ixJAVr8CSlv1XUPrleAawqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fa83bb-1c78-499f-9955-08dc7eae28c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:05.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck3YrSaZD65n9QjOZdl8tsNaOGyFXxPV0djAAOCfhK+9szEXHYrirhTwz4BqIAHKW7KdTt8eJ+oiEJTYS9BRmso/6q0g3nCgc7DG/cJTAfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: uOP2J1tWwx4LLgccY5Bo5yYUseXCkem_
X-Proofpoint-ORIG-GUID: uOP2J1tWwx4LLgccY5Bo5yYUseXCkem_

Pull out the PREEMPT_DYNAMIC setup logic to allow other preemption
models to dynamically configure preemption.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 165 +++++++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 79 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c26b60c1101..349f6257fdcd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8713,6 +8713,89 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
+#if defined(CONFIG_PREEMPT_DYNAMIC)
+
+#define PREEMPT_MODE "Dynamic Preempt"
+
+enum {
+	preempt_dynamic_undefined = -1,
+	preempt_dynamic_none,
+	preempt_dynamic_voluntary,
+	preempt_dynamic_full,
+};
+
+int preempt_dynamic_mode = preempt_dynamic_undefined;
+static DEFINE_MUTEX(sched_dynamic_mutex);
+
+int sched_dynamic_mode(const char *str)
+{
+	if (!strcmp(str, "none"))
+		return preempt_dynamic_none;
+
+	if (!strcmp(str, "voluntary"))
+		return preempt_dynamic_voluntary;
+
+	if (!strcmp(str, "full"))
+		return preempt_dynamic_full;
+
+	return -EINVAL;
+}
+
+static void __sched_dynamic_update(int mode);
+void sched_dynamic_update(int mode)
+{
+	mutex_lock(&sched_dynamic_mutex);
+	__sched_dynamic_update(mode);
+	mutex_unlock(&sched_dynamic_mutex);
+}
+
+static void __init preempt_dynamic_init(void)
+{
+	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
+		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
+			sched_dynamic_update(preempt_dynamic_none);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
+			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else {
+			/* Default static call setting, nothing to do */
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
+			preempt_dynamic_mode = preempt_dynamic_full;
+			pr_info("%s: full\n", PREEMPT_MODE);
+		}
+	}
+}
+
+static int __init setup_preempt_mode(char *str)
+{
+	int mode = sched_dynamic_mode(str);
+	if (mode < 0) {
+		pr_warn("%s: unsupported mode: %s\n", PREEMPT_MODE, str);
+		return 0;
+	}
+
+	sched_dynamic_update(mode);
+	return 1;
+}
+__setup("preempt=", setup_preempt_mode);
+
+#define PREEMPT_MODEL_ACCESSOR(mode) \
+	bool preempt_model_##mode(void)						 \
+	{									 \
+		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
+		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
+	}									 \
+	EXPORT_SYMBOL_GPL(preempt_model_##mode)
+
+PREEMPT_MODEL_ACCESSOR(none);
+PREEMPT_MODEL_ACCESSOR(voluntary);
+PREEMPT_MODEL_ACCESSOR(full);
+
+#else /* !CONFIG_PREEMPT_DYNAMIC */
+
+static inline void preempt_dynamic_init(void) { }
+
+#endif /* !CONFIG_PREEMPT_DYNAMIC */
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 #ifdef CONFIG_GENERIC_ENTRY
@@ -8749,29 +8832,6 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
  */
 
-enum {
-	preempt_dynamic_undefined = -1,
-	preempt_dynamic_none,
-	preempt_dynamic_voluntary,
-	preempt_dynamic_full,
-};
-
-int preempt_dynamic_mode = preempt_dynamic_undefined;
-
-int sched_dynamic_mode(const char *str)
-{
-	if (!strcmp(str, "none"))
-		return preempt_dynamic_none;
-
-	if (!strcmp(str, "voluntary"))
-		return preempt_dynamic_voluntary;
-
-	if (!strcmp(str, "full"))
-		return preempt_dynamic_full;
-
-	return -EINVAL;
-}
-
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
 #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
@@ -8782,7 +8842,6 @@ int sched_dynamic_mode(const char *str)
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
 
-static DEFINE_MUTEX(sched_dynamic_mutex);
 static bool klp_override;
 
 static void __sched_dynamic_update(int mode)
@@ -8807,7 +8866,7 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: none\n");
+			pr_info("%s: none\n", PREEMPT_MODE);
 		break;
 
 	case preempt_dynamic_voluntary:
@@ -8818,7 +8877,7 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: voluntary\n");
+			pr_info("%s: voluntary\n", PREEMPT_MODE);
 		break;
 
 	case preempt_dynamic_full:
@@ -8829,20 +8888,13 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
 		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: full\n");
+			pr_info("%s: full\n", PREEMPT_MODE);
 		break;
 	}
 
 	preempt_dynamic_mode = mode;
 }
 
-void sched_dynamic_update(int mode)
-{
-	mutex_lock(&sched_dynamic_mutex);
-	__sched_dynamic_update(mode);
-	mutex_unlock(&sched_dynamic_mutex);
-}
-
 #ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
 
 static int klp_cond_resched(void)
@@ -8873,51 +8925,6 @@ void sched_dynamic_klp_disable(void)
 
 #endif /* CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
 
-static int __init setup_preempt_mode(char *str)
-{
-	int mode = sched_dynamic_mode(str);
-	if (mode < 0) {
-		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
-		return 0;
-	}
-
-	sched_dynamic_update(mode);
-	return 1;
-}
-__setup("preempt=", setup_preempt_mode);
-
-static void __init preempt_dynamic_init(void)
-{
-	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
-		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
-			sched_dynamic_update(preempt_dynamic_none);
-		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
-			sched_dynamic_update(preempt_dynamic_voluntary);
-		} else {
-			/* Default static call setting, nothing to do */
-			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
-			preempt_dynamic_mode = preempt_dynamic_full;
-			pr_info("Dynamic Preempt: full\n");
-		}
-	}
-}
-
-#define PREEMPT_MODEL_ACCESSOR(mode) \
-	bool preempt_model_##mode(void)						 \
-	{									 \
-		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
-		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
-	}									 \
-	EXPORT_SYMBOL_GPL(preempt_model_##mode)
-
-PREEMPT_MODEL_ACCESSOR(none);
-PREEMPT_MODEL_ACCESSOR(voluntary);
-PREEMPT_MODEL_ACCESSOR(full);
-
-#else /* !CONFIG_PREEMPT_DYNAMIC */
-
-static inline void preempt_dynamic_init(void) { }
-
 #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
 
 /**
-- 
2.31.1


