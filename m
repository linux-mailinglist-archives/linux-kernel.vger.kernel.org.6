Return-Path: <linux-kernel+bounces-564068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB927A64D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979513B2526
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89606EED6;
	Mon, 17 Mar 2025 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="Q8V6s/9x"
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2117D346
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211932; cv=none; b=eorgnAtHJCnAMdAnsTc7RF/ByI+8hKRqgdO4NeqvDGCy5gWsJBls8+SjBdHvVyhwmGZBypRuUdZfnR48eSI1ShsLuggZwrpiNkfjaBCbVTY7ack6QI1R4p6cSEjcWCSdOGw3/Yc/z0WPZkiV+PxoDMjy/C3mMkXSwkUz7eu3EGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211932; c=relaxed/simple;
	bh=hhnIm6T94gB27SgYf0UY3q16p2S9qisBQ92xnKlNn8A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TAaok4yAQy4dMERpqmiE+p4rc3ALjZumKd1KQ84Mky4k1jwgeRSVuOEnWQ0mBh2EAiXipLnAYOUv5ALXozFf3YORRtqdfkhpFJK0Bx/AgiSVwPT85hbnygxDHAOLnQLG6C2wuU78afsh+23pzBLM3fKRfSV/CyYyphzaWUfE/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=Q8V6s/9x; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ntI7zWmcsXzPUVWEHAFv4p7510PGp6fVrYmgfrStXsQ=; b=Q8V6s/9xQVK8iRH2NJSa7eJ+Yd
	UcM9p0hqMirml26qEX3sGZ0Q5z4MMtznx5X/JQsdlIF9/23a3ZgSY+LTMT4t4uvNH38gYAdazyV3w
	VDvRmqmvw/icKKXg5baNbEQORkQeTp3ZOeWwq65MTJfrzRNBKtONwi0hIVw+/msACGpUbdRB863Ox
	/CSiJupilRfaiWclt/bvoT3Lrq1GZ5jq1AUjA9ea7emKWT4xmKuHowob+IafQJSzeGELnxvcsZMii
	qOuM4NOgc/ToFSuFyU7G5aeQDZDUEWoXEz2OS9422B/i5d8T86I5JoTTvqLutz8tbgKAKm/BdMrxJ
	FBawYabw==;
Received: from [122.175.9.182] (port=19732 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1tu8VL-000000006I9-3mNW;
	Mon, 17 Mar 2025 16:49:36 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 4A016178245B;
	Mon, 17 Mar 2025 16:49:31 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 33B3C1783FED;
	Mon, 17 Mar 2025 16:49:31 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3B2FHv0nDjmA; Mon, 17 Mar 2025 16:49:31 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 0C121178245B;
	Mon, 17 Mar 2025 16:49:31 +0530 (IST)
Date: Mon, 17 Mar 2025 16:49:30 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: nm <nm@ti.com>
Cc: basharath <basharath@couthit.com>, ssantosh <ssantosh@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	danishanwar <danishanwar@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, afd <afd@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>, parvathi <parvathi@couthit.com>, 
	Kevin Hilman <khilman@baylibre.com>
Message-ID: <1365068627.843903.1742210370862.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250307210517.5xjfc6wntcbj3s4k@precision>
References: <20250108125937.10604-1-basharath@couthit.com> <20250108125937.10604-2-basharath@couthit.com> <20250307210517.5xjfc6wntcbj3s4k@precision>
Subject: Re: [PATCH v2 1/1] soc: ti: PRUSS OCP configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: PRUSS OCP configuration
Thread-Index: DvRQZaXzAimB/uZVNUsWawvfCP38Jg==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Nishanth,

> On 18:29-20250108, Basharath Hussain Khaja wrote:
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> Updates OCP master port configuration to enable memory access outside
>> of the PRU-ICSS subsystem.
>> 
>> This set of changes configures PRUSS_SYSCFG.STANDBY_INIT bit either
>> to enable or disable the OCP master ports (applicable only on SoCs
>> using OCP interconnect like the OMAP family).
>> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> 
> On the verge of applying this patch, looking deeper, I noticed
> drivers/bus/ti-sysc.c managing the sysc controls. infact, I wonder if
> b2745d92bb015cc4454d4195c4ce6e2852db397e ("bus: ti-sysc: Add support
> for PRUSS SYSC type") could be merged with this?
> 
> 
> Could you say why drivers/bus/ti-sysc.c would'nt be the right solution?
> 
> Ccying Kevin if he has any ideas about this.
> 

Thank you for the feedback.

We will analyze ti-sysc and revert back with an update shortly.


Thanks and Regards,
Parvathi.

