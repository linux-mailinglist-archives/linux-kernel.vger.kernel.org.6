Return-Path: <linux-kernel+bounces-312204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBDC969387
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A351F23C28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8401D04BF;
	Tue,  3 Sep 2024 06:16:46 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407A1D54CB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725344202; cv=fail; b=sMkQdd7LxddBn3lrCWD6QS2rZxdezSjW2+k3j/cqQOJPL4uBzz3ttFflari2549uX+oiVnSSmntnx1YzJ0nGd2IyQu28YKu5XnZkRAmg4KznBPruhM4RRSPYar75fL0e6B/8dR1dWC9wzGWcRPBn+8uN66KDODj5A/yBpUtONYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725344202; c=relaxed/simple;
	bh=S41tit9PWnAgsXuCDFgNlipxy1Iii1QYiSzGf05gZqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CLMYY9jlavWyWvlHyi+bLlLFUZHHao+JIJFAulHkZcEfrTCn5wC8IZW7y+g8xvCdz5vCzoWBAX85mtpSilQ2Dn+tuwOHWlZ3DbOPG2lUjNN5PFKGsLxQ1y3AJrLwKkeyQqgXbI92GX/lcJjMQt/MWIQsqDJ13xiwRGn/RjgT5Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4834eJXo006124;
	Tue, 3 Sep 2024 06:15:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41bt59ajt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 06:15:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqwWGCxmVlYb+FZopuaeHj70+kyWgzkZDAT3GdHPFo0p9Ap/73Z+xQNqFlyJCZxxA5REHo24B/PfkjxMqz35Z4whi4Di7VHcM1+PoXbLx8UqZNIJ6S4cU4Ot18X+bIO9najL/hmF6kao+7zOl8qBPMjP6QmaiLN+/+nIy8i6cz6lS08rlLZZYaZ0yj87Iw/sxfdg/taWEZnuwJLwjtq49WeWo0HpcVF5nOEPK+3jKnUBS+QhGAIY++uUI1WvHmnd1pizCrzHHMS1A/ti5Kg3nXRGH+K2EHVHCpXzE+ssraea/pIms8wkPcid8Xkz8+AuNbmnbBC4J5W1q8BrUCHgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R0nDWgBjJwLVM5Zu254Wax8Z8+06cpsQVFLN+GYzyI=;
 b=wDL07Po71Sx7jHcsJYCrva59tHaQ0O3gW1p3ZyhDxlutVfVPH2eneh780WH3YA/RkAj65vImsXeNWZf77JvEEQxPDr5JDN5pVroN8SIWkVIlaqW0WQzs+k7KqakbfvAzrTsPvomgfiE1DXYBCOnIRkoQlc7YLOU1eRB7BFy13tKMOFm+fxkROkNAZb+890fr58VBHFUlQ2Tnm5GxsYkrNUCNRk8v37UpqzpN/Sxl8AJ5LVGr4ieRfJNtE2xrfAb4NrVdBiwBiOSYCh7LJ/tEKnVID+jbBXrayRdliI8r2cvEzDOolJyqNTsXkM0XS8cSWa81CplA8mUeaXrMEI5/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by MW4PR11MB7077.namprd11.prod.outlook.com (2603:10b6:303:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 06:15:49 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 06:15:46 +0000
From: guocai.he.cn@windriver.com
To: jan.kiszka@siemens.com
Cc: bp@alien8.de, henning.schild@siemens.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, xenomai@xenomai.org
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
Date: Tue,  3 Sep 2024 14:15:20 +0800
Message-Id: <20240903061520.1661650-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com>
References: <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::22) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|MW4PR11MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0d9eb5-b45e-4d65-12f4-08dccbdfd965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRDnh1FOJ/uLzDRif7G//OIFeFTauGkw7pKE68HtCGpppdKgN/GdvtmcDMHS?=
 =?us-ascii?Q?Fs8ZOt3vWIHPnxCB6R0ttHKfgl2yhSOKEp2/an2t2bg3HgL8MH2jY1/aXgkF?=
 =?us-ascii?Q?yy8WkWlo3ktEN2nvYwhm7auUCVju++RtW2QkwQVMAKwZTebxZr1TwXmpdmKq?=
 =?us-ascii?Q?eSeFF1HENmjG/5nJMwHnFhwwfoZavgCDmfigpmTdNobWSYUdBVjDiYMjHILQ?=
 =?us-ascii?Q?aaUhFXssqUpNSqCNqwN3Z5ojUjUpQciQAxn26RSiFpt2FUhI/qm+uVV9Lwj7?=
 =?us-ascii?Q?1Xhj/FyDPk4HMOG03BxRLNPv7VUWExePMghak+GTZ0c7KEbMXNL5Mg8UUrOj?=
 =?us-ascii?Q?NE7VRRs7WDdHF8pJ5kcY1pYLdr77cLmTw85R7jMcG2h5N8un8VGllgnaJ6s0?=
 =?us-ascii?Q?451PRNytamt5IcX6yNkqrmw6OtLDkAn9tPXFQ4Dx2Y8uIOCtm5qkMP5WP76c?=
 =?us-ascii?Q?J1mdEP/HFB6q5Lc3RqCXkI1VK7QtBGGUSBLUEg508mQZi6lcb5ZDPQVvmY18?=
 =?us-ascii?Q?2GhJ71GIh3G8HHtyW6BzJc5CclAEZTIhDHPYLq1vZOQWs1QMUDOWrIVX3y+k?=
 =?us-ascii?Q?b7m5pLhlvyrS/phV/sEiPlRFr4SHBc+cqP9S1tMm5pHI7w9x/kPoTHBXF3Pb?=
 =?us-ascii?Q?6k8VzBkdqZ+XVvuJy7e9u5UoUNxZuuvj/ICJGpb1may9L1DR/bS9o3P9eEkT?=
 =?us-ascii?Q?x5mvqzQa11nEwME4G5dCU21uauLMH2i6atwZPehPVOKP5/vUSqSnKbxxWqSo?=
 =?us-ascii?Q?b3Hu7C3icGRvkHglqxBDVbGM/mByUNrLM7f92qQDq9hkwS/uH/M4LmNauyDi?=
 =?us-ascii?Q?rdA683z+QhdVt3u8amxAUaZw9eiapDRYI0DPyKodjQJYoi6+5z7CeKr4JLdH?=
 =?us-ascii?Q?UPtR5KeajGo4TrkjruBvYEdQM0r4jAx+CSi/61sujTLkiCv1E+CxLmbZ1B1W?=
 =?us-ascii?Q?4WkNRfbYoepSzOl3DXqW1knmwV7ChAL25gPk/lfqo00hO1VvcgGdFUp89ywZ?=
 =?us-ascii?Q?b+sj6kGwr8onAUuP9patSS+Yi2uzzeTBe2nhS/vwIaGGwuk0A88VQqi4q5jK?=
 =?us-ascii?Q?w+nYo7Lh5/fZ6WnHc4BYMUY4xdTyjEk1qRi0Afgusf3LjB6eLdJPriDPkv3I?=
 =?us-ascii?Q?x8ZkF9+rx449QejZmX0A1rAz5FT4MmAi/4Zssm15K2fLL6dDN/Ymob/goccS?=
 =?us-ascii?Q?2pxu7JIIXDMbZyNVmNPtLNakKiKoQJ/RNvnS/9ZEX9RkT5K7atd5cnmBYj9B?=
 =?us-ascii?Q?ECDMv02xFimfAQ4fvqHvc34A3Q/t90jGr6fmCvHN8LrbE3iFFsq34KVuyr+I?=
 =?us-ascii?Q?QCt25xqPj/T6IubohQ2lKlFZL6fWeVRmCZPyRO5/hOCo9mbIz7wZX+rdnvV9?=
 =?us-ascii?Q?fdkZ3ap5JgoFKD4ylWVDugKDX7CXX1v8+zrlIrCfHV8XX90drQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZoBarfXoy7LnUeKnfYfkR34lgMxDZO05zu1118qAcqcN43apzpLlRwK3iuu5?=
 =?us-ascii?Q?3/wEknS8Dih13om7C74BWVz3POgglybvOKeco8KVj/x6xsQp3zTImD81vxXV?=
 =?us-ascii?Q?AMIL1IyDkju5LfoG8V/hEMG/OWYlQ78HLqyVtrYF2JsAIspUSHI/18rkemp0?=
 =?us-ascii?Q?8Sog1eraUttUt+q6tXdfEJTgAINFDH3fSI6N3uyH04hKNrLkv0EsUTsh1kKa?=
 =?us-ascii?Q?qiQ0YU3BmO0GCPib6rDUFlx2GZt8QQ5Hs7xkWvwKuBmfXG06KfQluB78+D0+?=
 =?us-ascii?Q?iuVFsrJA2wdzxwoQU99uGT9fKVBUkDLxbpq4eOkg5ufXLcMVeotZICqRKe+y?=
 =?us-ascii?Q?q1wZaWpet8C2EhUfdL1p32GPOoZ00GrqlcT4WXpTbW82devmJx3rHeA97lcX?=
 =?us-ascii?Q?/8d1E5HVdgLkyBhLoESg7W5AFIDmnzf9fnolNg9PniTnBKt3h4SKTpG2XRb/?=
 =?us-ascii?Q?j0jCo0nYeZlyrqocfHai8D2R9V3/Y/uCGB5cqFeVrJNujeMtXNBOVqMIQyYK?=
 =?us-ascii?Q?bf1o1E/xM9bJ3vpGVCb/u/Rj32OUB1kJYo/GT6M51kzrKMqvvk3sH8oIIV05?=
 =?us-ascii?Q?Zwjve4WNN2CufEC1oVArXb2pu5NrRjjXZO8aSvBpv85NeDUNnPGLXYyZ3+eq?=
 =?us-ascii?Q?YyY3yPI+lEN4WkjiFIyzeodlQuFtxgZqTQR3boACZ2cBRqOAgT0YQzeBZ7+W?=
 =?us-ascii?Q?oefXq1smdfhb9HPEk/53+3hrNzHXTSVAK+eTofDOVVSr6m3E0wE5Oy/Wix7V?=
 =?us-ascii?Q?Gv7WOTJccOLDpJHJFA/2bubotUXL8pfSKh/stQeeYWf+ZgVyInXDkKUcDpAc?=
 =?us-ascii?Q?uBDG1/WV2Gdq8LKkOjczQn2AgoOPqoOa6Mq8RA6u94/e8Lbn14voeKTkGPy4?=
 =?us-ascii?Q?QgViQe1qkvRyjFT1TbRl9yQwiTHGGOrzABxbuaLFoN3nhXCvIAQessmiKIkI?=
 =?us-ascii?Q?rJCUnR+t5zkHI73jt7Lmr2cEdGu0sqMP/fzXD1XKHYQxUrUrRgW0PpCiQ969?=
 =?us-ascii?Q?h081sItPpFRZiku1FC8wY4XV0G3btDy050iB6X1NNHx1OCLYDkV3Xja7RWNj?=
 =?us-ascii?Q?w6XYhsTIWG1gBaL+Q5mPBDR7qdpiJitCySJ8MELNxHySIpJnLbNVY8gOcHbY?=
 =?us-ascii?Q?NEJyjoBIAryIuo7Bz76VhUTUi2JjFsQf0c+/eoOa1R/5+mWUzLKVS335wJzb?=
 =?us-ascii?Q?C+4gUTQAWQ43MAkiE1QB/ALOdCS1omUpIco+/FFZ2K03VQWNRMn1pCxZLhYT?=
 =?us-ascii?Q?3OzPgoEroTyfCz3BEoSFjttwBo0t72doccjoDqewL1QXJVwg5joxcDw0wb4P?=
 =?us-ascii?Q?e0OzFHmKGUwPTYi9CaFQsJknIT5iOG//rWa4f4JAqWskVHzDp54ZJ8Q6WJJ+?=
 =?us-ascii?Q?9NgYpXxrbZvzo7RZJRbWoijiav6Fowgn2aKnq5aqN3bz/KhpZ3b+NHfmVqLD?=
 =?us-ascii?Q?CYXwalRzlekpJsyFP3R30dVZRjnDE+wHiDA4Yu0506cnb6J7NzzqnYJ7+410?=
 =?us-ascii?Q?Gvd3LnCd5CK4kSAE2ojMhLMlrkVi7mV/F15nQS9IlVG/ikG5GjXIkQB2BbSM?=
 =?us-ascii?Q?i6GfDuitwo1npy7CW8NypaWQgqgXZCtozKtzp/QOR0RlUoaM2Z5lSBzqTg35?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0d9eb5-b45e-4d65-12f4-08dccbdfd965
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 06:15:46.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyVzYq8hQo7bMt75P2v7CNXn+phapbKwx2+6YHrttQ6TyYfXfMFQvd70v3ndmc5gmvxK5EkqQCCfF9XCN8Afr61OLaf63Dgdith6vuuAmXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7077
X-Proofpoint-ORIG-GUID: 1YA5c_Bel-5PGvO_p99e_gG6z5TMMh97
X-Authority-Analysis: v=2.4 cv=DN/d4DNb c=1 sm=1 tr=0 ts=66d6a998 cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=_WaBhyow_EwcTpgtPgUA:9
X-Proofpoint-GUID: 1YA5c_Bel-5PGvO_p99e_gG6z5TMMh97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=932 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2409030048

if there have any updates or fixes about this issue?

we meet the similar issue, logs as following:

root@doon:~# poweroff
...............
...............

-----------[ cut here ]-----------

sched: Unexpected reschedule of offline CPU#10!

WARNING: CPU: 0 PID: 446324 at arch/x86/kernel/smp.c:126 native_smp_send_reschedule+0x3a/0x40

Modules linked in: vhost_net vhost macvtap tap xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_r

eject_ipv4 iptable_mangle iptable_nat linux_user_bde(PO) linux_kernel_bde(PO) xt_tcpudp bridge stp ll

c ip6table_filter ip6_tables iptable_filter ip_tables x_tables kvm_intel kvm vfio_pci vfio_virqfd vfi

o_iommu_type1 vfio pci_stub iavf uio_pci_hostif i40e(O) configfs qfx_pci_static_map(O) macvlan socktu

n(O) i2c_dev uio_fpga(O) uio intel_rapl_msr iTCO_wdt iTCO_vendor_support watchdog intel_rapl_common x

86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crct10dif_common aesni_intel aes_x86_6

4 glue_helper crypto_simd cryptd i2c_i801 igb(O) lpc_ich pcc_cpufreq sch_fq_codel nfsd openvswitch ns

h nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 irqbypass fuse [last unloaded: ebtab

les]

CPU: 0 PID: 446324 Comm: kworker/0:11 Tainted: P           O      5.2.60-rt15-LTS19 #1

Workqueue:  0x0 (rcu_gp)

RIP: 0010:native_smp_send_reschedule+0x3a/0x40

Code: 4f 9b 01 73 17 48 8b 05 34 1c 5b 01 be fd 00 00 00 48 8b 40 30 e8 a6 ac fb 00 5d c3 89 fe 48 c7

c7 28 08 b1 b8 e8 42 5c 02 00 <0f> 0b 5d c3 66 90 0f 1f 44 00 00 8b 05 3d f8 ba 01 85 c0 0f 85 e1

RSP: 0018:ffff9dc940003c68 EFLAGS: 00010086

RAX: 0000000000000000 RBX: ffff9138c00a3400 RCX: 0000000000000006

RDX: 0000000000000007 RSI: 0000000000000003 RDI: ffff9138bfe16450

RBP: ffff9dc940003c68 R08: 0000099801c9bf9b R09: 0000000000000000

R10: ffff9dc940003a08 R11: 0000000000000002 R12: 000000000000000a

R13: ffff9dc940003d30 R14: 0000000000000000 R15: ffff9138c00a3400

FS:  0000000000000000(0000) GS:ffff9138bfe00000(0000) knlGS:0000000000000000

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

CR2: 00000000000000b0 CR3: 0000000305364006 CR4: 00000000003606f0

DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Call Trace:

<IRQ>

resched_curr+0x69/0xc0

check_preempt_curr+0x54/0x90

ttwu_do_wakeup.isra.0+0x1e/0x150

ttwu_do_activate+0x5b/0x70

try_to_wake_up+0x224/0x570

? enqueue_task_fair+0x1f0/0xa70

? tracing_record_taskinfo_skip+0x3f/0x50

default_wake_function+0x12/0x20

autoremove_wake_function+0x12/0x40

__wake_up_common+0x7e/0x140

__wake_up_common_lock+0x7b/0xf0

__wake_up+0x13/0x20

wake_up_klogd_work_func+0x39/0x40

irq_work_run_list+0x4f/0x70

irq_work_tick+0x3b/0x50

update_process_times+0x65/0x70

tick_sched_timer+0x59/0x170

? tick_switch_to_oneshot.cold+0x79/0x79

__hrtimer_run_queues+0x10f/0x290

? recalibrate_cpu_khz+0x10/0x10

hrtimer_interrupt+0x109/0x220

smp_apic_timer_interrupt+0x76/0x150

apic_timer_interrupt+0xf/0x20

</IRQ>

RIP: 0010:finish_task_switch+0x87/0x280

Code: 85 c0 0f 8f dc 00 00 00 8b 05 e5 6b bd 01 85 c0 0f 8f e7 00 00 00 41 c7 45 40 00 00 00 00 41 c6

04 24 00 fb 8b 05 e9 f0 b5 01 <65> 48 8b 14 25 00 5d 01 00 85 c0 0f 8f 23 01 00 00 4d 85 f6 74 1d

RSP: 0018:ffff9dc94725bdf8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13

RAX: 0000000000000000 RBX: ffff9138a093c180 RCX: 0000000000000001

RDX: 0000000000000000 RSI: ffff9138a093c180 RDI: ffff9138b9298040

RBP: ffff9dc94725be20 R08: 000000000000022d R09: ffff9138a093c258

R10: 0000000000000000 R11: 0000000000000000 R12: ffff9138bfe23400

R13: ffff9138b9298040 R14: 0000000000000000 R15: 0000000000000002

? __switch_to_asm+0x34/0x70

__schedule+0x30b/0x690

schedule+0x42/0xb0

worker_thread+0xc1/0x3c0

kthread+0x106/0x140

? process_one_work+0x3f0/0x3f0

? kthread_park+0x90/0x90

ret_from_fork+0x35/0x40

--[ end trace 4ff5842bcc9fa5e0 ]

