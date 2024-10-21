Return-Path: <linux-kernel+bounces-373839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113139A5D87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA67281462
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1E1E0E08;
	Mon, 21 Oct 2024 07:50:08 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC71E0DF3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497007; cv=none; b=e4YYh2ADmQW/liDT8IhYjCWR1ZoBsMu89QWqJJa7nVYRrBNmqzITzEmxliyzrwjUO/a2w9XF1aot7qZAakyC9osxAT7U63TfWsBbMtvBtrE6CbJV/x0P2o5im2xJl3OKPfQdSoKxIcObjATGHzMQtHzWojhLfXK4/HaEZJdWCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497007; c=relaxed/simple;
	bh=MeSPUEu4aroRvWcUFbbfD3U1640yPblXHyoz9jlFJGI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RM9pvDSPaJTVzecvIaidGB3AHmyqpGBXMOto5ansYLt1bkiWdpnnrvW2DNshIAKUaFrI46QoYZ+nN5XsIthtz+2vE4PIq9X3//Q7ec8+tu8DSyIc1L4DLpaT6zvPzlJYjTORDgNgbajH9cVl9zIcqsEX+alADPkifbaIrY7jL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:3e71:ec8b:abc6:b434])
	by albert.telenet-ops.be with cmsmtp
	id Svpx2D0023tSf9h06vpxGg; Mon, 21 Oct 2024 09:49:57 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t2nAq-004Eao-U2;
	Mon, 21 Oct 2024 09:49:56 +0200
Date: Mon, 21 Oct 2024 09:49:56 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various compliance
 requirements.
In-Reply-To: <2024101835-tiptop-blip-09ed@gregkh>
Message-ID: <a520d1f5-8273-d67e-97fe-67f73edce9f1@linux-m68k.org>
References: <2024101835-tiptop-blip-09ed@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Greg,

Thanks for your patch, which is now commit 6e90b675cf942e50
("MAINTAINERS: Remove some entries due to various compliance
requirements.") in v6.12-rc4.

On Fri, 18 Oct 2024, Greg Kroah-Hartman wrote:
> Remove some entries due to various compliance requirements. They can come
> back in the future if sufficient documentation is provided.

This is very vague...
What are "various compliance requirements"?
What does "sufficient documentation" mean?

I can guess, but I think it's better to spell out the rules, as Linux
kernel development is done "in the open".  I am also afraid this is
opening the door for further (ab)use...

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

