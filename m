Return-Path: <linux-kernel+bounces-376741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDDA9AB55A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346462817C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DEE1C0DC5;
	Tue, 22 Oct 2024 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="L8MbITeD"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E511BE23F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619018; cv=none; b=PSGPfwfg9CCKtVbHKp7NqxYe3+Q8UFuOjGDQjh2ta97/pUbVXjT5K4MOfecumjFhYoSdSVF1mM3cWhfMqcu2mb/qoJb/3gSdJDnvln5K8j+uNAYiWtBgHpnzTRdoSYnLu7KsBQNqFPUr7DbNQtncXs6VT86He+Ux0yYGBjjq1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619018; c=relaxed/simple;
	bh=Cko+J094pa09qis/IPFfAwUwxH+yIqcbrXJUtNYDkrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfyrqN+9B5658Smc/fw5DunnA1epBb338GqK7Q+3ffZq8he7v02KsHCknbYQdTBb6Stt7nybTSziqp2DFd+0KogJ8GJISdPh/GNTNcRz/rATNnAta05mSnWffOlinf/TBz8alU9BGI4AQaDIKNOgq2YvkX+PGhX2sRzGfQO2FGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=L8MbITeD; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729619012;
 bh=Cko+J094pa09qis/IPFfAwUwxH+yIqcbrXJUtNYDkrI=;
 b=L8MbITeDqddiEA+pMLC3OVOGmmIRppHVucktO/a0kfhKBWnGGXnn6zDbi0iKnZPNvZEp/ym/5
 OhUHXf+6qWcRnSYltA+GVDnd4PM8LVXowO5mk+5ECxmFyWM7cs3la9a2RyBn1JfI9p10o9c9ugG
 7Quvu3rBo+9IcM7FgAgRTjtEjDD0Nev24m+JaArCdtQj1/qNP5MHRRyrQHigF8TLEfe7ZjQ20sr
 0U0qrlaC64gJrNbIYbci6QF1SbAwoNpTsk629/t6eUxnG2HQXNt32/M/F05AiJTaXaV1yPoyjqM
 nZ+jncs8I10RqwG3jQMqHw3D7n+2aVJQKPyfsPN4vzvw==
Message-ID: <04e2e389-ba45-4d77-a152-6705b0d92ba1@kwiboo.se>
Date: Tue, 22 Oct 2024 19:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thinking about firmware and hardware description for latest
 Rockchip platforms
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241022165413.2156-1-shimrrashai@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241022165413.2156-1-shimrrashai@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6717e442289888ca1b5a3b18

Hi,

On 2024-10-22 18:53, Shimrra Shai wrote:

[snip]

> However, because
> of the need to have a specific device tree blob file for each board
> along with the kernel, one cannot just use the typical USB stick and
> install process at least with the commonly used bootloaders assuming
> a PC architecture.

U-Boot now use latest Linux device tree for all RK35xx boards (and older
Rockchip aarch64 SoCs). With the EFI feature of U-Boot you can already
boot any distro raw aarch64 image, as long as the kernel is new enough.

E.g. for RK356x you can use latest debian, ubuntu, opensuse and freebsd
aarch64 raw/uefi image and boot into the installer from a USB stick.

However, there is no display support in U-Boot for RK35xx so you will
have to use serial console to do the installation, and be sure to leave
around 16 MiB of space on SD-card/eMMC before first partition to not
overwrite any existing bootloader.

Btw, regarding the EDK2 RK35xx port, please consider to update to use
mainline U-Boot SPL and not a vendor SPL blob, you could also benefit
from using binman to generate the final firmware image, bundling the
ddr init blob, U-Boot SPL and EDK2 in a firmware package.

Regards,
Jonas

[snip]

