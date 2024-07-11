Return-Path: <linux-kernel+bounces-249852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6091292F0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0651C28222E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8D19F489;
	Thu, 11 Jul 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg1qpoyF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617919F470;
	Thu, 11 Jul 2024 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732216; cv=none; b=ca1VsfMUVLBtXjLnTocLwDYfi8/q+YTpZyX7vf4T2e4yoXLnt6Bo+C1lkrybh2qn1B6ezV4tza/Dn3ZTjDhUe9YD9fq3bVDCkX3DJh4o99O244x+uPaHN/nUEOATdVDccSkUSHxYmZGzzVBNyZEoZX8dQQrFyMDxkOxqvqlo5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732216; c=relaxed/simple;
	bh=UTRCsaBAwJ27kZVR9fIIRwXN90jfM8+V9iZaFILqX6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9WYLR5Os80DBpZaLN1FbE0mCh0bTY2gO3bZjuo9qDI0hqo5rqRfs7ww6ZoFU0pMcZXfOSOVU9r8x+LDWNklFD6uDHRwFm37UffmefkGYS8TrCr+F83fsgpYC+ugh2Fqx7LuF+j7K3YKrEoUQBkcBmEistwv8QNkHU3vaT+KVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg1qpoyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A88C116B1;
	Thu, 11 Jul 2024 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720732216;
	bh=UTRCsaBAwJ27kZVR9fIIRwXN90jfM8+V9iZaFILqX6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fg1qpoyFsQsZrFT8A+dixSkFvTM5ZfE0Hp7w0ZFs0Xl8bcAgcnD+LiDcpL48sTUxc
	 NPWK5QxB2Wl19mLRAiQoan5+RuEBD9LbYpIeADvWqA5JHAbkfX62eZ3n/PJKzrLA3s
	 LW7GSkmfmGZU/t/i1Xk4+YjjER1lLb6SaI5V3Bm2Kq+sv6a1dhzYBKJbouk0k+WqBe
	 MvcBNj0FgF7uYizy4j6hWkboC2ne4UsP1bn0iWiGqb0z4DZT1xVZYjObb1crrT8PDW
	 ogjih0CB5u8zSOxth5PqynhrwXpBgpPUBCFsLE/Y0cORU+OMgQG/UZS2proTJ/tlTm
	 D/JTH9wG56EUQ==
Date: Thu, 11 Jul 2024 15:10:14 -0600
From: Rob Herring <robh@kernel.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, prusovigor@gmail.com,
	kernel@salutedevices.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] ASoC: Add NTP8918 and NTP8835 codecs support
Message-ID: <20240711211014.GA3008651-robh@kernel.org>
References: <20240709221203.92167-1-ivprusov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709221203.92167-1-ivprusov@salutedevices.com>

On Wed, Jul 10, 2024 at 01:11:57AM +0300, Igor Prusov wrote:
> This series adds support for two NeoFidelity amplifiers. For both
> amplifiers vendor provides software for equalizer and filters
> configuration, which generates firmware files with registers values.
> Since in both cases those files have same encoding, a common helper
> module is added to get firmware via request_firmware() API and set
> registers values.
> 
> V1: https://lore.kernel.org/all/20240709172834.9785-1-ivprusov@salutedevices.com/
> 
> V1 -> V2:
>  - Fix dt_binding_check errors

Please implement the comments on v1. Please don't send new versions 
right away and give people time to review. We're not all on the same 
timezone, get busy on other tasks, take vacation, etc.

Rob

