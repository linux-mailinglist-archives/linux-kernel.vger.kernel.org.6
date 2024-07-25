Return-Path: <linux-kernel+bounces-262033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5356693BFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E093FB219BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F3198857;
	Thu, 25 Jul 2024 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPhRVPDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59317557C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902714; cv=none; b=L46WJk6y2qJDNGFwxPe786dKjux8QbNvKHcAHFVWSjspZ11eRfxZdMjpvLpn4C+KBzS0//0mL0iSrhi2UPce++fDQJEVKaekHml1CEa8AfuvYXQ2fNYzAVSHKbMqe/iJYP4gsvBz6UXOolZl7c4ZZFXfwTc8ElnPMmTSQoPV/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902714; c=relaxed/simple;
	bh=pJsiWDK14V7PpgZvU8Sw1BfjY7OBrZZYcAM/jjdn9ko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WGDKqfs0qnX33YbttGgwBVuDep+uyzCmQP1hHM2gLvmzEpMlOi0ppG44JhqvWOcaIiRWY+HikPWfrPnLkPTCPFcIptc3cm624aSHoKDIZJ4If6bHd1Nt3bq70NA2BIVcDqlLtBGlSEW30y/FzXB83GqYAJjHrvTD4XqYCMIEmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPhRVPDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18206C116B1;
	Thu, 25 Jul 2024 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721902713;
	bh=pJsiWDK14V7PpgZvU8Sw1BfjY7OBrZZYcAM/jjdn9ko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FPhRVPDPkF7oOwrOnVqClJDUlnWzKYjJqyDY7AassWGDZF1Vxw5a5tUO59cS8FOLv
	 ParhKJOoo5XofEwcZPMdzqetTMqzSUQ2coSU+6jtyO+g9ZzMxN+2Fkf0BUzJz52kiO
	 Fk7dbY2rEDu+HnKzEoDrUqAvRR+bIf55z7UmRPk9VK1D8I3se4Ns1/wVXokhoIYFad
	 KlO5vf6KWQDBtZQssZbGBKVyWeObk5Pe5NzjCj/R6Z3f/cMUWTfrPR4IOZuJAW32eC
	 MAL3JGmdXQK/o7mi0hzSSPMWHw9vd5vbFabUME+zhVTGlvsMcudHtKgvaZN0grUuDU
	 Fp5MmQSlu7jcw==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZpTbGHb6EX2Oe7ok@monster.localdomain>
References: <ZpTbGHb6EX2Oe7ok@monster.localdomain>
Subject: Re: (subset) [PATCH] mfd: ds1wm: remove remaining header
Message-Id: <172190271281.922794.6897054699945062934.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 11:18:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 15 Jul 2024 08:17:28 +0000, Wilken Gottwalt wrote:
> The driver was removed after kernel 6.2, keeping the header around
> doesn't make much sense.
> 
> 

Applied, thanks!

[1/1] mfd: ds1wm: remove remaining header
      commit: c8f7a8fdd49b75a8c9e2752a20e723b697b8b504

--
Lee Jones [李琼斯]


