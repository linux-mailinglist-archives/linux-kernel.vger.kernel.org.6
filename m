Return-Path: <linux-kernel+bounces-414020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4234A9D21E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53F0B210D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789519CD19;
	Tue, 19 Nov 2024 08:52:55 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552318A950
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006374; cv=none; b=iQrJmK5ydbM4WXr7uwj2dSfKqQN+Y04zFu/9JW8g6rm4d5sLYxQZ5RFn+GzqfR9PzQRXmrLNxV1XdmVKP0sP/x7Gm13et4LI+8xfgAEZHd8iD7eEicoeB05OrMKspd7ppt0d0FRqbevxdlo+IYw1OTJJI/0RKOhcf4s3dLMguRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006374; c=relaxed/simple;
	bh=gGjaNLipNPH/z2T2kjNOIQxF0oOJsvtgmLBujtUovzk=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IMIOMbrxu+B7kt5l9JLVjrrTIQ5Yp2lCVu/NCTWigbQDqGO+ot3UJSJv2nA/oZ5L5zZNQC7EorrNwiNaA2xy8W3cvnIaBUydeRGVGi8uZmSUyILoULXV9iA1GvL59gbG5XzT3q+VCT2LPr5phY8RXXxn3d9MgFoQdmUjZ9h8hKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:90:c2fd:9e4:224c])
	by michel.telenet-ops.be with cmsmtp
	id eYsk2D0073aMPyX06YskKy; Tue, 19 Nov 2024 09:52:44 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tDJyW-007VjQ-1f
	for linux-kernel@vger.kernel.org;
	Tue, 19 Nov 2024 09:52:44 +0100
Date: Tue, 19 Nov 2024 09:52:44 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.12
In-Reply-To: <20241119084859.3561753-1-geert@linux-m68k.org>
Message-ID: <4447cf15-448-ce17-b34a-a0a3f4a1b60@linux-m68k.org>
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com> <20241119084859.3561753-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 19 Nov 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.12[1] to v6.12-rc7[3], the summaries are:
>  - build errors: +5/-0

Move on, nothing to see here but SuperH gcc ICE crickets.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

