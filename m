Return-Path: <linux-kernel+bounces-563803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E0A648C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E937E3AC439
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9196C23315F;
	Mon, 17 Mar 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DEPD6TQb"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B62222D5;
	Mon, 17 Mar 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206072; cv=none; b=ni4FNgQaCUCwDKLwaUJiQhO4AfZqruI6bVqg7Iym+5Pk2jholgvHc8Bz42am1Udvlhj5lD/iTNhM9sj73LInuTDfvBrtQi0bYMXRcMsVtMfTYOAmIhyTp96Y3rowXrcMWMkL8g3UtTiX/8/O1KDRVH39kn2LAzWGG4u1zF9etJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206072; c=relaxed/simple;
	bh=8lS5hmgPL3TYuQclYZ9vfPxIWeswa/Pdrh0fXPBcwWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tsdy+YtYoysl3ZZo872lIwLWE+2VfoNELEocuYMS/FljPE0Sri7VrleogB+1h5eTwEzxNRiuJlZjG37okK2PW1gs0ir4h4WDvMSPBJ/PCWmbgdp4lHiNp1aZLvWsVsbqTtAOphAYzcCjMzcdvDrlcsDGdh3SroZZxE93Cv5IIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DEPD6TQb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742206068;
	bh=8lS5hmgPL3TYuQclYZ9vfPxIWeswa/Pdrh0fXPBcwWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DEPD6TQb2muBQx4U2eHrGHZLYQx3/7kW6Fli7xueDlalRM/j9T8zhrj/vuRfyUy3B
	 EW2VLZvytpoeGtcJkbhKJrPDlZ870TCWsvtom80M6Ai3BOkLBDUgnpnFnbpTYgP+s9
	 x9vEqQWUyO+AwmMjAGX7hszhkKEI/ecu3gUrNtzZNWMrPXJEVz31GshUMquLPrQZYg
	 3KSL9ajKzChu9PJGectraGgPEM9apNi6JuKASwlWkwBamNEVXRBvGwI2PEtBifXf0C
	 EvKs962aMsWgUHm+2a7BQLFSImlkAjQG3x+YUtPKidztC2TUQVXHXMiJLcw1dAJSda
	 1SfI6F9mH3nRg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2619217E0385;
	Mon, 17 Mar 2025 11:07:48 +0100 (CET)
Message-ID: <375d5281-41f5-49e8-ac20-d58931c0c1f9@collabora.com>
Date: Mon, 17 Mar 2025 11:07:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/3] add VCP mailbox and IPC driver
To: Jjian Zhou <jjian.zhou@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20250317083822.891-1-jjian.zhou@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250317083822.891-1-jjian.zhou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/03/25 09:38, Jjian Zhou ha scritto:
> The VCP mailbox has 5 groups. Each group has corresponding interrupts,
> registers, and 64 slots (each slot is 4 bytes). Since different features
> share one of the mailbox groups, the VCP mailbox needs to establish a
> send table and a receive table. The send table is used to record the
> feature ID, mailbox ID, and the number of slots occupied. The receive table
> is used to record the feature ID, mailbox ID, the number of slots occupied,
> and the receive options. The API setup_mbox_table in mtk-vcp-ipc.c calculates
> the slot offset and pin index for each feature ID based on the mailbox ID and
> slot number in the send and receive tables (several slots form a pin, and
> each pin can trigger an interrupt). These descriptions are written in the
> mtk-vcp-ipc.c file -- we call it the IPC layer.
> 
> We have two questions:
> How should we describe the mailbox and IPI?
> Can the intermediate IPC layer be rewritten as a virtual mailbox layer?
> 

So, for this remote processor messaging system you have:
  - Dynamic channel allocation
    - Each channel has its own endpoint
    - Each channel has its own interrupt
  - Data send operation
    - Both with and without ACK indication from the remote processor
    - To channel -> endpoint
  - Data receive operation
    - From channel <- endpoint
    - When interrupt fires
    - Could use polling to avoid blocking in a few cases
  - A custom message structure not adhering to any standard

Check drivers/rpmsg/ :-)

On MediaTek platforms, there are many IPI to handle in many subsystems for
all of the remote processors that are integrated in the SoC and, at this
point, you might as well just aggregate all of the inter processor communication
stuff in one place, having an API that is made just exactly for that, instead
of keeping to duplicate the IPI stuff over and over (and yes I know that for each
remote processor the TX/RX is slightly different).

If you aggregate the IPI messaging in one place, maintenance is going to be easier,
and we stop getting duplication... more or less like it was done with the mtk_scp
IPI and mtk-vcodec .. and that's also something that is partially handled as RPMSG
because, well, it is a remote processor messaging driver.

Just to make people understand *how heavily* MediaTek SoCs rely on IPI, there's
a *partial* list of SoC IPs that use IPI communcation:

thermal, ccu, ccd, tinysys, vcp, atsp, sspm, slbc, mcupm, npu, mvpu, aps, mdla,
qos, audio, cm_mgr.... and... again, it's a partial list!

That said... any other opinion from anyone else?

Cheers,
Angelo

> Example of send and recve table:
> Operation | mbox_id | ipi_id | msg_size | align_size | slot_ofs | pin_index |  notes
> send          0          0       18          18           0          0
> recv          0          1       18          18          18          9
> send          1         15        8           8           0          0
> send          1         16       18          18           8          4
> send          1          9        2           2          26         13
> recv          1         15        8           8          28         14       ack of send ipi_id=15
> recv          1         17       18          18          36         18
> recv          1         10        2           2          54         27       ack of send ipi_id=2
> send          2         11       18          18           0          0
> send          2          2        2           2          18          9
> send          2          3        3           4          20         10
> send          2         32        2           2          24         12
> recv          2         12       18          18          26         13
> recv          2          5        1           2          44         22
> recv          2          2        1           2          46         23
> 
> Recv ipi_id=2 is the ack of send ipi_id=2(The ipi_id=15 is the same.)
> 
> Jjian Zhou (3):
>    mailbox: mediatek: Add mtk-vcp-mailbox driver
>    firmware: mediatek: Add vcp ipc protocol interface
>    dt-bindings: mailbox: mtk,vcp-mbox: add mtk vcp-mbox document
> 
>   .../bindings/mailbox/mtk,mt8196-vcp-mbox.yaml |  49 ++
>   drivers/firmware/Kconfig                      |   9 +
>   drivers/firmware/Makefile                     |   1 +
>   drivers/firmware/mtk-vcp-ipc.c                | 481 ++++++++++++++++++
>   drivers/mailbox/Kconfig                       |   9 +
>   drivers/mailbox/Makefile                      |   2 +
>   drivers/mailbox/mtk-vcp-mailbox.c             | 179 +++++++
>   include/linux/firmware/mediatek/mtk-vcp-ipc.h | 151 ++++++
>   include/linux/mailbox/mtk-vcp-mailbox.h       |  34 ++
>   9 files changed, 915 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml
>   create mode 100644 drivers/firmware/mtk-vcp-ipc.c
>   create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
>   create mode 100644 include/linux/firmware/mediatek/mtk-vcp-ipc.h
>   create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h
> 




