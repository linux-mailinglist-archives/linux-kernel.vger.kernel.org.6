Return-Path: <linux-kernel+bounces-304443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB796201B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA1B282002
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D3158546;
	Wed, 28 Aug 2024 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="B9vKMvIH"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513F15821D;
	Wed, 28 Aug 2024 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828137; cv=none; b=rUvmEJ6QVvcsrHu4mPUf4ssMeKMDkJaHDi3NL7qhZ3W8XIe/ER1kjR0hmYvw63pwbdZXuU2q2L58MTwC62kfE8jwQA2YtNghJMMt6RX4gomeUSzgVH5aT9WK/WG4FmJMLuEY8u6C0onlZ/Wd5CEhoz5sYiujdMOxLH6pDxmJI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828137; c=relaxed/simple;
	bh=dN9SfQCq4guAcS4JmXFLMcxDK++OXwepQ++b9A58S6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBHW8yuQ4SNx6oYJ2XjU0bahd2NUq79zDJPaqyfI2ZrhLR/jMcexybtaTp6J1B0q/53h87tr6I5leleL6I7sn+iTXpnSu6F4nnQMga6VaySubHfLh8cDTNREDu1o1GkxbQ1i4nxST6Urj/4Goa9BBQIu/QQTyWZZIlqAGxBNZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=B9vKMvIH; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35C94148348B;
	Wed, 28 Aug 2024 08:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724828133; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=D6HWi5sRAZLVzDQVs7rtnvxr3v+ffI11JPirkUZI48w=;
	b=B9vKMvIHFt/lxE/kbGdTB2WycGWlISVjojO4+XrattbxnDhekYYHxXddmjPsTD59YdJQS4
	ARG3wQMqF6pjbgnQ4FeCN/uPR7isQy0nr0fYCRJc8dqh6XjdVmtYPBRVsn1EVvDqv/fuuD
	j2Q9y+EdPa4YOgQMNEn/ADhLcppwzzwuD7L5CWAoR8J9UNGD4EmKDx+jwYJS4Jp51zx57t
	PKW49QpjsFA0OUSShS0Hpxgebk9QZisoZZH6XBPUOSQHfSk7lIdp0q0x6iBjC34bQ5ZAuf
	RPSpvcZFZPVucAkDAqTqv78XDoH0pNb79ZkKiM4zHU6bswJVfd6iVPcAn4Yxvw==
Date: Wed, 28 Aug 2024 08:55:27 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: get, prepare, enable a clock not in DT?
Message-ID: <20240828-gainfully-cringing-2f420d8882bd@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
 <384919bc-7d45-445a-bc85-630c599d43ef@tuxon.dev>
 <20240820-grandpa-down-fec4231f971c@thorsis.com>
 <e7f69aa3-20a7-4233-96c7-0fa5fe67bbdc@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7f69aa3-20a7-4233-96c7-0fa5fe67bbdc@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Fri, Aug 23, 2024 at 05:29:44PM +0300 schrieb claudiu beznea:
> 
> 
> On 20.08.2024 15:17, Alexander Dahl wrote:
> > By chance: I don't have a sama7g5 based board at hand for testing.
> > The datasheet says the same as for sam9x60.
> > Does the nvmem_microchip_otpc driver actually work without timeout on
> > sama7g5?
> 
> Yes! This should be because system bus is clocked from MCK0 (as mentioned
> in peripheral identifiers table) which is enabled by bootloader.

Not sure I can follow.  Citing the SAMA7G5 datasheet section 30.4
(OTPC Product Dependencies):

    "The OTPC is clocked through the Power Management Controller
    (PMC). The user must power on the main RC oscillator and enable
    the peripheral clock of the OTPC prior to reading or writing the
    OTP memory."

Table from section 8.5 (Peripheral Clocks …) has no check mark at "PMC
clock control" but indeed lists MCK0 as main system bus clock.  If it
works on SAMA7G5 without explicitly enabling main RC oscillator, then
either that clock is on accidentally, or the datasheet is wrong in the
OTPC section.

Personally I find the "clocked through PMC" part in the OTPC
section suspicious, because in the peripheral identifiers table OTPC
has no "PMC Clock Control" mark.

Not sure what's the difference between SAM9X60 and SAMA7G5 internally,
though.  From a user's POV it's possible one of them requires the
main RC osc, and the other does not, but currently you can't tell from
the datasheets.

> Here is a snapshot of reading the NVMEM on a SAMA7G5 with bootconfig and
> thermal calibration packets:
> https://www.linux4sam.org/bin/view/Linux4SAM/ThermalFaq

Greets
Alex


