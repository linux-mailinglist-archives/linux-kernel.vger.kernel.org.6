Return-Path: <linux-kernel+bounces-444526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD469F0852
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483F11691F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878D61B4126;
	Fri, 13 Dec 2024 09:46:31 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6A1B3935;
	Fri, 13 Dec 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083191; cv=none; b=OwLOj2ECqRJccoDfmqlCMifJv34BHcTPueSGbpifRx3GhqftFHpjBQNdtXRBGIe4FYe5GH5X96ohtVF+Du9ExNOR4s4uhgAEhBum70k7ZOlHDcwr3NvV+V9FOHcf/uNhTVpcQWvOCQxxdubUAcGaMLRBqc67QATVGkBuQBZUvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083191; c=relaxed/simple;
	bh=wUVyz9N3T451oLgSRpBPO06ATHWuDcj6hBAKKbCk6mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okj+g3b+0NDhqpPVVDu7dFc1EWAMQBAb0HzAkMG2ZkkpuUeOfBR07hnguXu0t0l27hKAqJChfwuZw8oGL+rxES2NHlXrleqvgSjxAcaYV5TjwozuZqn+KFAiDMDOIsVM1g+CA0Fw30bONb0Py+A4jFvaFf4aTttD89sSOVJZC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af5e3.dynamic.kabel-deutschland.de [95.90.245.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 622D761E646F9;
	Fri, 13 Dec 2024 10:46:01 +0100 (CET)
Message-ID: <6bbe0989-babd-4a99-85ad-fdeea47deb09@molgen.mpg.de>
Date: Fri, 13 Dec 2024 10:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btmtk: add quirk to support
 HCI_QUIRK_SIMULTANEOUS_DISCOVERY
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Hao Qin <hao.qin@mediatek.com>,
 Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20241213094118.23647-1-chris.lu@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241213094118.23647-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chris,


Thank you for your patch.


Am 13.12.24 um 10:41 schrieb Chris Lu:
> Add quirk to support HCI_QUIRK_SIMULTANEOUS_DISCOVERY feature for MT79xx
> series chipset.

It’d be great if you elaborated. What is the problem. Why is a quirk 
needed? Is a firmware update going to fix it?

> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
>   drivers/bluetooth/btmtk.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 8a3f7c3fcfec..562d6ecf0b71 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1367,6 +1367,9 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>   			return err;
>   		}
>   
> +		/* Apply common HCI quirks for MediaTek chipset */
> +		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> +

The commit message only talks about MT79xx series chipset. The comment 
talks about all MediaTek chipsets.

>   		hci_set_msft_opcode(hdev, 0xFD30);
>   		hci_set_aosp_capable(hdev);


Kind regards,

Paul

