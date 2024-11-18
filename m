Return-Path: <linux-kernel+bounces-412797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2594A9D0F19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF3928281A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E69194A64;
	Mon, 18 Nov 2024 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="FmTRPmDH"
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50639152166
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927701; cv=none; b=jwoVeRQr12rNiyV5lG642vvc1F1gwVhVS5QBfIjKfD41NvRcg8eApbs9HkbZUERz50MWIVw70eH6y+F5e9FTrpDD5+GAAOcsg47uLFalHKNhFDXPzglpOYiQGhxvtGpEmBvxc/YtvTLZVuhLreHBFO8VY6gueXEHMyRhW9vqYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927701; c=relaxed/simple;
	bh=L3DXAKtK78rvpMrsQIbYoN78a+mgMIA/LYWqn1mO3N8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=QhFGxn38biDaO/BAmEZ3UQoCda1dxPht7r9Sp8xmG1lo7JIK4cNN9DUerWrt9vv0oEPWOO84ZVt720aAEHaUMIbTqY8g9h9QImcjS2Mm7acHGEMFAjqUDJ7sa3mhDFOSnF+7XPW1fjgnlqJwkFg470HW1SXLHhM9xk2/1iPfytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=FmTRPmDH; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 8EC4F8357AD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:55:09 +0100 (CET)
Received: from [IPV6:2a01:cb08:8ba8:b200:7080:4cd2:4ce9:d616] (unknown [IPv6:2a01:cb08:8ba8:b200:7080:4cd2:4ce9:d616])
	(Authenticated sender: eric.valette@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1BA98B0053D;
	Mon, 18 Nov 2024 11:55:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1731927302;
	bh=L3DXAKtK78rvpMrsQIbYoN78a+mgMIA/LYWqn1mO3N8=;
	h=Date:Reply-To:To:From:Subject:From;
	b=FmTRPmDHzAgLs6Btema7Uz6fgkVx1haQ31kzVxp1pAmPIPs54rhnzgzcRfg8MPzK6
	 Yo/64VYHf4xFSdQI7o+/cWpAT7s6q91ZJ2mJ1tHlFV6+EGS3eL4YCQjYwkFHjb9aRp
	 oynhc6G0KhNSYTmrpZWjk/A1vf86tFaPLJ3HS9pyiQ7r2kdRKqKfXIMnQyxhxtEcoF
	 qxzqXe5ygjXGyGR+DjdiSuWedEvvCOk9JXNLr3vnEyXc0meeHMu50tIVVccz6sW7KX
	 KwTrm7m8uTnchU8320L2dLyeHrTVbuEmmQHDI9fM5WI3jBJ0qZYATFUKPAEIolrXW5
	 HSqQUlcTtS/gg==
Message-ID: <b19187f3-3729-4a7f-b014-3a0c68a29ebd@free.fr>
Date: Mon, 18 Nov 2024 11:55:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.valette@free.fr
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
From: Eric Valette <eric.valette@free.fr>
Subject: Efistub permanent warning depending on number of boot entries. Can
 anyone try to en-light me?
Autocrypt: addr=eric.valette@free.fr; keydata=
 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
 wycNoa755G2xgOMORgXEMg==
Organization: HOME
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

All of sudden, I saw a permanent new warning message from EFI code when 
booting my Linux machine:

EFI stub: WARNING: Failed to measure data for event 1: 0800000000000000b

After a bit of investigation I saw it came from efistub code but as it 
also happened on old kernel that did not exhibit the message initially, 
I was wondering if it was related to efi BIOS change made by M$ (SBAT 
dual boot problem was fresh...).

I hunted the web but found nothing really accurate and the gave up.

Then, one day, I decided to clean up the old kernel images I had 
accumulated in my /boot directory, not by hand, but by doing:

apt remove --purge linux-image-6.6.x linux-headers-6.6.x

Thus calling update-grub at the end of the process

And by chance, I noticed that the EFI warning message was gone.

This morning I compiled a fresh 6.6.62 kernel and message was back. 
Rebooted several time, and it was always there.

Then Did

apt remove --purge linux-image-6.6.60 linux-headers-6.6.60

To keep only previous working kernel and message was gone.

My system is debian unstable + experimental stuff for kde6

grub on my system it at version 2.12 and shim 15.8.

Note that I have two windows system detected by grub and another linux. 
They are bootable via efi or grub for some (those that are on the same 
disk) but as the problem seems to be only related to a given system boot 
entries...

Has anyone an explanation. Please share it.

PS;: please CC me as I'm not subscribed.

-- 
Eric Valette


