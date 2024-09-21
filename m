Return-Path: <linux-kernel+bounces-334907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52F97DE27
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3661C20B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1323A8E4;
	Sat, 21 Sep 2024 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB4GZ5VH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF9208D0;
	Sat, 21 Sep 2024 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726941942; cv=none; b=ZWEOiDx6e2a5pAABwnm6wAOzbCgmYI7CX+AsKtDKdvUhF7w/pNSeWkhZxuiRZIaPXx3wss0fGIrlL+6R+ozbZr5JNWIaF7dBigo7lGssjgBZ2gccV0VD2e7IrXhCe8rtlkHpJrpk3zPaDlsJcQUHOb38kSLbBsQ1DCoj+ujYRTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726941942; c=relaxed/simple;
	bh=P0nis9qL8sE4IF9dqa9UxIwQqZVyOb8pEolAPPOYYUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp8PKZw0UTCa0mpu+iX532Cj8fcFvBxmXIuSz+72lVTv5fX8LyC15Wj19KcPkZ1aEg3AUOL3IHQOkXVq0QfqaOLzsJEdCLry28IAg3BwsoHCFqq6TGfD2L/3C21x6CY9W8m4WZZnJILWX7F/QMiujvm8/I35+d9eIo3DP84RBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB4GZ5VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC23C4CEC2;
	Sat, 21 Sep 2024 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726941940;
	bh=P0nis9qL8sE4IF9dqa9UxIwQqZVyOb8pEolAPPOYYUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LB4GZ5VHj1UMFtL4y0hCDskFo8/l0Jcl1jIF0r9c6iAyUt2vdbzwZRSYGMMZaUuyA
	 RvVdkV3VVKQq10tAZZqcxj7tSyP88g0OjF2arrtisw5AxGa1IODw33Z+LwIb6uY2Oe
	 i/2+Iw9fEc9o/GA7W9VS2KgKl9KEtTcqp0pfKhKSYrDAnonKVU6GKG2Od+bKX475z0
	 H47gkex6T0ekcH/9B32RaHMUXZRjv6UsgWNHnVJTEiznnclmH4tQWGUXDKfoXsE1lE
	 RPc9lnDK7pVbZp+ff2HZj3M9fg5Fj/kY7JBpLqVIVRYGTYkXz1rTPojEwAyqUf+BfH
	 HACRS1JthMSiA==
Date: Sat, 21 Sep 2024 20:05:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, prusovigor@gmail.com, kernel@salutedevices.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] ASoC: dt-bindings: Add bindings for NeoFidelity
 NTP8835
Message-ID: <w36jlnksfym2bwsyxhvk2fs3yxf5xvmfu5j37z5bf2y4kjpbbu@wcy4egrsmefj>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
 <20240709172834.9785-6-ivprusov@salutedevices.com>
 <4cb531b8-5ea1-437f-bdb0-a49f7799af47@kernel.org>
 <20240920174233.hisfcfb6pgtqzyfp@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920174233.hisfcfb6pgtqzyfp@pc>

On Fri, Sep 20, 2024 at 08:42:33PM +0300, Igor Prusov wrote:
> On Wed, Jul 10, 2024 at 12:24:33PM +0200, Krzysztof Kozlowski wrote:
> > On 09/07/2024 19:28, Igor Prusov wrote:
> > > Add dt-bindings for NeoFidelity NTP8835C/NTP8835C Amplifiers
> > > 
> > > Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> > > ---
> > >  .../bindings/sound/neofidelity,ntp8835.yaml   | 65 +++++++++++++++++++
> > 
> > No need for new schema. Just put it - after testing - into previous
> > bindings file.
> 
> I am going to add some clocks in next version and there are some
> differences between amplifiers. 8835 uses separate master clock, 8918 is
> clocked by BCLK. Is it still better to use same schema with anyOf, or
> keep them in different files?

No clue, that was 2 months ago so I don't have that email in my inbox at
all.

Please post complete bindings (regardless whether driver implement it or
not), so we can see the differences.

Best regards,
Krzysztof


