Return-Path: <linux-kernel+bounces-323299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B85973AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43B61C25400
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FB919992A;
	Tue, 10 Sep 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="W4vK/zoo"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE01DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980593; cv=none; b=sQHBc002CJCFdhDu7Q+Zf/+nI7t51IMpJvwQABQUKjJYkCNRhkbg1jRsOjeQw07dSdnJ1ZGUEj5LY3SjhA4J4lwrnw6CsrjLtocaIAs5NHneLY7XLn/SVUzGNNvfaEb5qatQbtrfGdz3TTdj1E0fHzL2l6DdPPlIw4z6zjf5XOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980593; c=relaxed/simple;
	bh=d0doP1JEFX/C18a6HowMf6zIsMYbUDOyVenZRHR3MV8=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=Qo+Rg9hTIVpJUwP1rG9qpdPzMdxknp2yI3PxuyRLcH6AsHZpChy7Y4tXTPixJ4/6gvIl2OckIwQc9n6XBl7gfYW8XKQo2ShbDaPg8KRg6QIi7hSaYT4iytVEQIf5fcq3WbheAT6skpVZMHDmz1WyKeRu5QU52Wwo6o7NlNuVK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=W4vK/zoo; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id nwjDs1LMJumtXo2OUsA9fR; Tue, 10 Sep 2024 15:03:02 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id o2OQsQm0xeCxMo2ORsXnl8; Tue, 10 Sep 2024 15:03:00 +0000
X-Authority-Analysis: v=2.4 cv=M/yGKDws c=1 sm=1 tr=0 ts=66e05fa4
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=-pn6D5nKLtMA:10 a=VwQbUJbxAAAA:8
 a=j3ABsGMAZ6_o1Ezv-SsA:9 a=QEXdDO2ut3YA:10 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:Cc:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TJ85ArdoYlxuS6vKFMT9SPvP3V1lonosUWTKH5D5ndM=; b=W4vK/zoopOdslcnBvpuci1/kVl
	0MDUEEHsAvDha/xHnh0xQLWxcqzY9kgZacJONVCWe/EdYPkcC3tgIFekOskEL6tweWlFWzeLcdKpS
	DYvU1PQikHq7JsiLcspmMq/QOACdGBJYr/af9UvunMfJzIpl3DCCXBvTPqILIIJw7D86aXfTMshqi
	JJHGnTP5NcKSomxP0FyPHL1NoNXykWcGcOXBeWXR3dmEWsO0tGYP9M9ZZAlQThZQV2nOjv3l2j8M8
	kgiclSWljz/5QLZjDh7hAjADU6zRWsrWiMdwVC7T3Cs3pgMgf00phanKzdFggmAvWte72TMATgFR7
	S8fSQhUA==;
Received: from [122.165.245.213] (port=57984 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1so2OP-000kTi-00;
	Tue, 10 Sep 2024 20:32:57 +0530
Message-ID: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
Date: Tue, 10 Sep 2024 20:32:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, dhowells@redhat.com,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
To: david@sigma-star.at
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
Subject: Trusted keys: DCP: Unable to handle paging request
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1so2OP-000kTi-00
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:57984
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPoOwfW9JeK0LhqYT6vyjSBFUcrmk6SzMCAHhmMJeFGmcO3qiQXYbdKTTj6/dTdTcs/VtrOSYpoHo6VM+52es2VtjLGmt9rKhZAeo8PDdlhDkPMW2UJ7
 M/HEzPXDAf/dNe6cI3Ctdyge3GA7Afh9m5Ps1uUJT8xeb9sT+6p/w+BuvLo/GkArMvczzWSLB9MIIkOoXLQq3QhHZRMs3ju9EN8=

Dear David,

The below commit when using the stack memory for encrypt/decryption, unable to
add the key using keyctl. IMO the encrypt/decrypt request which is submitted to
the dcp driver is asynchronous and seal/unseal is returned before the completion.

crypto_wait_req with aead_request_set_callback will help?

+ keyctl add trusted kmk 'new 32' @u
[   18.345069] 8<--- cut here ---
[   18.348199] Unable to handle kernel paging request at virtual address e00125a0 when read
[   18.356321] [e00125a0] *pgd=00000000
[   18.359948] Internal error: Oops: 5 [#1] SMP ARM
[   18.364597] Modules linked in:
[   18.367688] CPU: 0 UID: 0 PID: 35 Comm: mxs_dcp_chan/ae Not tainted 6.11.0-rc7-00017-gbc83b4d1f086 #20
[   18.377035] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   18.383235] PC is at page_address+0x8/0xf4
[   18.387393] LR is at dcp_chan_thread_aes+0x170/0x7e8
[   18.392412] pc : [<c0281a94>]    lr : [<c06d0dc0>]    psr: 800e0013
[   18.398703] sp : e0a85f00  ip : 00000100  fp : 00000000
[   18.403951] r10: c241c640  r9 : e0845db0  r8 : c2715490
[   18.409201] r7 : e0c2ddbc  r6 : 00000000  r5 : c2715280  r4 : e00125a0
[   18.415754] r3 : e0c2ddbc  r2 : e00125a2  r1 : c27152ed  r0 : e00125a0
[   18.422308] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   18.429476] Control: 10c5387d  Table: 8270406a  DAC: 00000051
[   18.435244] Register r0 information: non-paged memory
[   18.440334] Register r1 information: slab kmalloc-192 start c2715240 pointer offset 173 size 192
[   18.449206] Register r2 information: non-paged memory
[   18.454286] Register r3 information: 2-page vmalloc region starting at 0xe0c2c000 allocated at kernel_
clone+0x9c/0x340
[   18.465051] Register r4 information: non-paged memory
[   18.470133] Register r5 information: slab kmalloc-192 start c2715240 pointer offset 64 size 192
[   18.478906] Register r6 information: NULL pointer
[   18.483641] Register r7 information: 2-page vmalloc region starting at 0xe0c2c000 allocated at kernel_
clone+0x9c/0x340
[   18.494395] Register r8 information: slab kmalloc-192 start c2715480 pointer offset 16 size 192
[   18.503166] Register r9 information: 2-page vmalloc region starting at 0xe0844000 allocated at kernel_
clone+0x9c/0x340
[   18.513918] Register r10 information: slab kmalloc-512 start c241c600 pointer offset 64 size 512
[   18.522780] Register r11 information: NULL pointer
[   18.527603] Register r12 information: non-paged memory
[   18.532773] Process mxs_dcp_chan/ae (pid: 35, stack limit = 0x4cccc1b5)
[   18.539428] Stack: (0xe0a85f00 to 0xe0a86000)
[   18.543825] 5f00: 00000000 c2715280 00000000 e0c2ddbc c2715490 c06d0dc0 00000000 00000000
[   18.552041] 5f20: c22e3480 c0901a08 00000000 c2715490 c0b57a80 00000000 c22e3480 00000000
[   18.560256] 5f40: c2344040 e0c2ddbc 00000002 124e0e4e c2345040 e0c2ddcc 00000001 c27152c0
[   18.568469] 5f60: c241c640 c242c080 e0845db0 c2419e80 c22e3480 c06d0c50 00000000 c242c080
[   18.576680] 5f80: e0845db0 00000000 00000000 c0141fe8 c2419e80 c0141f10 00000000 00000000
[   18.584890] 5fa0: 00000000 00000000 00000000 c010016c 00000000 00000000 00000000 00000000
[   18.593101] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   18.601309] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[   18.609509] Call trace:
[   18.609537]  page_address from dcp_chan_thread_aes+0x170/0x7e8
[   18.617988]  dcp_chan_thread_aes from kthread+0xd8/0xf8
[   18.623280]  kthread from ret_from_fork+0x14/0x28
[   18.628031] Exception stack(0xe0a85fb0 to 0xe0a85ff8)
[   18.633115] 5fa0:                                     00000000 00000000 00000000 00000000
[   18.641326] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   18.649532] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   18.656188] Code: e12fff1e e12fff1e e92d41f0 e1a04000 (e5903000)
[   18.662306] ---[ end trace 0000000000000000 ]---
[   18.666949] note: mxs_dcp_chan/ae[35] exited with irqs disabled

git show --stat 0e28bf61a5f9ab30be3f3b4eafb8d097e39446bb 
commit 0e28bf61a5f9ab30be3f3b4eafb8d097e39446bb
Author: David Gstir <david@sigma-star.at>
Date:   Wed Jul 17 13:28:45 2024 +0200

    KEYS: trusted: dcp: fix leak of blob encryption key
    
    Trusted keys unseal the key blob on load, but keep the sealed payload in
    the blob field so that every subsequent read (export) will simply
    convert this field to hex and send it to userspace.
    
    With DCP-based trusted keys, we decrypt the blob encryption key (BEK)
    in the Kernel due hardware limitations and then decrypt the blob payload.
    BEK decryption is done in-place which means that the trusted key blob
    field is modified and it consequently holds the BEK in plain text.
    Every subsequent read of that key thus send the plain text BEK instead
    of the encrypted BEK to userspace.
    
    This issue only occurs when importing a trusted DCP-based key and
    then exporting it again. This should rarely happen as the common use cases
    are to either create a new trusted key and export it, or import a key
    blob and then just use it without exporting it again.
    
    Fix this by performing BEK decryption and encryption in a dedicated
    buffer. Further always wipe the plain text BEK buffer to prevent leaking
    the key via uninitialized memory.
    
    Cc: stable@vger.kernel.org # v6.10+
    Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys")
    Signed-off-by: David Gstir <david@sigma-star.at>
    Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

 security/keys/trusted-keys/trusted_dcp.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

-- 
Thanks,
Parthiban N

