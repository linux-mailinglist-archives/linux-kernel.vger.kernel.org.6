Return-Path: <linux-kernel+bounces-560020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE40A5FCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DE416689F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8AC268FE6;
	Thu, 13 Mar 2025 16:55:47 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40332E3390;
	Thu, 13 Mar 2025 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884947; cv=none; b=XmMHKEG8RnOiukz4lfiOFbsspJGGIrGQJoT66eV1znHGdDaDn5GdSP+UrQ5kbO6pIeLCSC4oJsuNN/aQHHyw+XOvMz/HavxBa1i+qV/Vk5o6y9WD0KJr2aPuCAWxt2Syboj80g8EuLJ1WlBblpwjqzWrU/Fohy0I9EQy9ucSs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884947; c=relaxed/simple;
	bh=aS+t1t51Ah30hbf5nUrtvEU3QDfoP/N2cxXyCUIYhYY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fY5xmeBPezOqCjhRN5AwGxioXemntzbt2s69N0QJy0wHxMlB0Y2Et4Lnw0LqR7mj97KJ7ogGJ7ktItcXnbNUocUptgYHXnXLSIyTahQRRgZiqMkJ4ZSxs3O30r7Waj7HaqG34f0/FPi77lrJP3ONyPK/Juii7ALpm4L9v5ibim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDD7g3xDLz6M4Px;
	Fri, 14 Mar 2025 00:52:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 86D671404F5;
	Fri, 14 Mar 2025 00:55:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 17:55:41 +0100
Date: Thu, 13 Mar 2025 16:55:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <20250313165539.000001f4@huawei.com>
In-Reply-To: <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
	<Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Mar 2025 17:20:52 -0500
Gregory Price <gourry@gourry.net> wrote:

> --------------------
> Part 0: ACPI Tables.
> --------------------
> I considered publishing this section first, or at least under
> "Platform", but I've found this information largely useful in
> debugging interleave configurations and tiering mechanisms -
> which are higher level concepts.
> 
> Much of the information in this section is most relevant to
> Interleave (yet to be published Section 4).
> 
> I promise not to simply regurgitate the entire ACPI specification
> and limit this to necessary commentary to describe how these tables
> relate to actual Linux resources (like numa nodes and tiers).
> 
> At the very least, if you find yourself trying to figure out why
> your CXL system isn't producing NUMA nodes, memory tiers, root
> decoders, memory regions - etc - I would check these tables
> first for aberrations.  Almost all my personal strife has been
> associated with ACPI table misconfiguration.
> 
> 
> ACPI tables can be inspected with the `acpica-tools` package.
>    mkdir acpi_tables && cd acpi_tables
>    acpidump -b
>    iasl -d *
>    -- inpect the *.dsl files
> 
> ====
> CEDT
> ====
> The CXL Early Discovery Table is generated by BIOS to describe
> the CXL devices present and configured (to some extent) at boot
> by the BIOS.
> 
> # CHBS
> The CXL Host Bridge Structure describes CXL host bridges.  Other
> than describing device register information, it reports the specific
> host bridge UID for this host bridge.  These host bridge ID's will
> be referenced in other tables.
> 
> Debug hint: check that the host bridge IDs between tables are
>             consistent - stuff breaks oddly if they're not!
> 
> ```
>          Subtable Type : 00 [CXL Host Bridge Structure]
>               Reserved : 00
>                 Length : 0020
> Associated host bridge : 00000007    <- Host bridge _UID
>  Specification version : 00000001
>               Reserved : 00000000
>          Register base : 0000010370400000
>        Register length : 0000000000010000
> ```
> 
> # CFMWS
> The CXL Fixed Memory Window structure describes a memory region
> associated with one or more CXL host bridges (as described by the
> CHBS).  It additionally describes any inter-host-bridge interleave
> configuration that may have been programmed by BIOS. (Section 4)
> 
> ```
>            Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 000000C050000000   <- Memory Region
>              Window size : 0000003CA0000000
> Interleave Members (2^n) : 01               <- Interleave configuration
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006
>                    QtgId : 0001
>             First Target : 00000007         <- Host Bridge _UID
>              Next Target : 00000006         <- Host Bridge _UID
> ```
> 
> INTER-host-bridge interleave (multiple devices on one host bridge) is
> NOT reported in this structure, and is solely defined via CXL device
> decoder programming (host bridge and endpoint decoders).  This will be
> described later (Section 4 - Interleave)
> 
> 
> ====
> SRAT
> ====
> The System/Static Resource Affinity Table describes resource (CPU,
> Memory) affinity to "Proximity Domains". This table is technically
> optional, but for performance information (see "HMAT") to be enumerated
> by linux it must be present.
> 
> 
> # Proximity Domain
> A proximity domain is ROUGHLY equivalent to "NUMA Node" - though a
> 1-to-1 mapping is not guaranteed.  There are scenarios where "Proximity
> Domain 4" may map to "NUMA Node 3", for example.  (See "NUMA Node Creation")
> 
> # Memory Affinity
> Generally speaking, if a host does any amount of CXL fabric (decoder)
> programming in BIOS - an SRAT entry for that memory needs to be present.
> 
> ```
>         Subtable Type : 01 [Memory Affinity]
>                Length : 28
>      Proximity Domain : 00000001          <- NUMA Node 1
>             Reserved1 : 0000
>          Base Address : 000000C050000000  <- Physical Memory Region
>        Address Length : 0000003CA0000000
>             Reserved2 : 00000000
> Flags (decoded below) : 0000000B
>              Enabled : 1
>        Hot Pluggable : 1
>         Non-Volatile : 0
> ```
> 
> # Generic Initiator / Port
> In the scenario where CXL devices are not present or configured by
> BIOS, we may still want to generate proximity domain configurations
> for those devices.   The Generic Initiator interfaces are intended to
> fill this gap, so that performance information can still be utilized
> when the devices become available at runtime.
> 
> I won't cover the details here, for now, but I will link to the
> proosal from Dan Williams and Jonathan Cameron if you would like
proposal

> more information.
> https://lore.kernel.org/all/e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com/

I know you said you'd not say more, but this is a bit misleading.

Maybe ignore Generic Initiators for this doc.  They are relevant for
CXL but in the fabric they only matter for type 1 / 2 devices not
memory and only if the BIOS wants to do HMAT for end to end.  Gets
more fun when they are in the host side of the root bridge.

# Generic Port

In the scenario where CXL memory devices are not present at boot, or
not configured by the BIOS or he BIOS has not provided full HMAT
descriptions for the configured memory, we may still want to
generate proximity domain configurations for those devices.
The Generic Port structures are intended to fill this gap, so
that performance information can still be utilized when the
devices are available at runtime by combining host information
with that discovered from devices.

Or just 
# Generic Ports

These are fun ;)

> 
> ====
> HMAT
> ====
> The Heterogeneous Memory Attributes Table contains information such as
> cache attributes and bandwidth and latency details for memory proximity
> domains.  For the purpose of this document, we will only discuss the
> SSLIB entry.

No fun. You miss Intel's extensions to memory-side caches ;)
(which is wise!)

> 
> # SLLBI
> The System Locality Latency and Bandwidth Information records latency
> and bandwidth information for proximity domains. This table is used by
> Linux to configure interleave weights and memory tiers.
> 
> ```
> Heavily truncated for brevity
>               Structure Type : 0001 [SLLBI]
>                    Data Type : 00         <- Latency
> Target Proximity Domain List : 00000000
> Target Proximity Domain List : 00000001
>                        Entry : 0080       <- DRAM LTC
>                        Entry : 0100       <- CXL LTC
> 
>               Structure Type : 0001 [SLLBI]
>                    Data Type : 03         <- Bandwidth
> Target Proximity Domain List : 00000000
> Target Proximity Domain List : 00000001
>                        Entry : 1200       <- DRAM BW
>                        Entry : 0200       <- CXL BW
> ```
> 
> 
> ---------------------------------
> Part 00: Linux Resource Creation.
> ---------------------------------
> 
> ==================
> NUMA node creation
> ===================
> NUMA nodes are *NOT* hot-pluggable.  All *POSSIBLE* NUMA nodes are
> identified at `__init` time, more specifically during `mm_init`.
> 
> What this means is that the CEDT and SRAT must contain sufficient
> `proximity domain` information for linux to identify how many NUMA
> nodes are required (and what memory regions to associate with them).

Is it worth talking about what is effectively a constraint of the spec
and what is a Linux current constraint?

SRAT is only ACPI defined way of getting Proximity nodes. Linux chooses
to at most map those 1:1 with NUMA nodes. 
CEDT adds on description of SPA ranges where there might be memory that Linux
might want to map to 1 or more NUMA nodes

> 
> The relevant code exists in: linux/drivers/acpi/numa/srat.c
> ```
> static int __init
> acpi_parse_memory_affinity(union acpi_subtable_headers *header,
>                            const unsigned long table_end)
> {
> ... heavily truncated for brevity
>         pxm = ma->proximity_domain;
>         node = acpi_map_pxm_to_node(pxm);
>         if (numa_add_memblk(node, start, end) < 0)
>             ....
>         node_set(node, numa_nodes_parsed);    <--- mark node N_POSSIBLE
> }
> 
> static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>                                    void *arg, const unsigned long table_end)
> {
> ... heavily truncated for brevity
>         /*
>          * The SRAT may have already described NUMA details for all,
>          * or a portion of, this CFMWS HPA range. Extend the memblks
>          * found for any portion of the window to cover the entire
>          * window.
>          */
>         if (!numa_fill_memblks(start, end))
>                 return 0;
> 
>         /* No SRAT description. Create a new node. */
>         node = acpi_map_pxm_to_node(*fake_pxm);
>         if (numa_add_memblk(node, start, end) < 0)
> 	        ....
>         node_set(node, numa_nodes_parsed);    <--- mark node N_POSSIBLE
> }
> 
> int __init acpi_numa_init(void)
> {
> ...
>     if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
>         cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
>                                     acpi_parse_memory_affinity, 0);
>     }
>     /* fake_pxm is the next unused PXM value after SRAT parsing */
>     acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
>                           &fake_pxm);
> 
> ```
> 
> Basically, the heuristic is as follows:
> 1) Add one NUMA node per Proximity Domain described in SRAT

    if it contains, memory, CPU or generic initiator. 

> 2) If the SRAT describes all memory described by all CFMWS
>    - do not create nodes for CFMWS
> 3) If SRAT does not describe all memory described by CFMWS
>    - create a node for that CFMWS
> 
> Generally speaking, you will see one NUMA node per Host bridge, unless
> inter-host-bridge interleave is in use (see Section 4 - Interleave).

I just love corners: QoS concerns might mean multiple CFMWS and hence
multiple nodes per host bridge (feel free to ignore this one - has
anyone seen this in the wild yet?)  Similar mess for properties such
as persistence, sharing etc.

J


