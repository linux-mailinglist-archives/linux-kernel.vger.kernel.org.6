Return-Path: <linux-kernel+bounces-435286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA17D9E75B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7CA188652B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2C215F76;
	Fri,  6 Dec 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK/1iR9K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC7211472
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501656; cv=none; b=oIcRjxWcXKcxA4ZtbJB5PyWgAREk53Bqy/A6YqZXxAEG2peVps9T0Kuo0tUK0j0TQxU5JPgeYCKl5yCe+zdB2807Jr74QeQ2v5vmpweBxKB3P/5tFVH6L5EzExBW7ag765sFNTRzIzcs5K495wPhqPXxBAh4kiiV9+frU9eVx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501656; c=relaxed/simple;
	bh=egg6B1XJqelvLMOaLPHyotIig6IkJjdVlydbWKdcwkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p16fifmZIKe6wcP1D5PRuKj9H/Etn5sw8nZGBdMaxL4p20rESSMKWnEfKvXz5RKoPM9AUFeaf7d9ARPAgrzYovJm4bcKzTM6BqQgHbeGGTuI1TGNpt6fDVmHSHOLfjZj1deK0ZI/xR033zs7YmIWjISXgzXAZvTBTS7A+zw+Ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK/1iR9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2426FC4CEDC;
	Fri,  6 Dec 2024 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501655;
	bh=egg6B1XJqelvLMOaLPHyotIig6IkJjdVlydbWKdcwkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uK/1iR9KLQw42qFVzDqumH9rtajoQUE/jPOMpBuCFAM8H9xKcYM6iBI+tOMVTgLif
	 gvcl1z0o+BU1OgYsFelfMFdhezrQ5qUZLZNEBAb5yXS0WtzFyJLxfbSeSeUi9HWkci
	 Ii9aAGw94PKiMCwUr8/gKoBGdDdOMngCfdlXkCIZo1rm5dyceLPyf49MYOmyZwCJpM
	 HwW1uI4Sb37yCEh4nQzNP6ZtaqDur+NUy/7ZUm5YxQM90mRB6iafYjUY0bxuZT7FZm
	 5BLZYt8HBLvacBe3P3WwI44y1l3H8TeGmv8mM882kHyQHFBZ46/eLSk3yIjj7WabIW
	 /nUynrTfWe++Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Parth Pancholi <parth105105@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Parth Pancholi
 <parth.pancholi@toradex.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: remove mx25u25635f from
 parts list to enable SFDP
In-Reply-To: <20241105105844.257676-1-parth105105@gmail.com> (Parth Pancholi's
	message of "Tue, 5 Nov 2024 11:58:44 +0100")
References: <20241105105844.257676-1-parth105105@gmail.com>
Date: Fri, 06 Dec 2024 16:14:13 +0000
Message-ID: <mafs0y10s3i22.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 05 2024, Parth Pancholi wrote:

> From: Parth Pancholi <parth.pancholi@toradex.com>
>
> The Macronix mx25u25635f flash device supports SFDP initialization.
> This commit removes the specific mx25u25635f entry (NOR ID 0xc22539),
> along with its size and flags, from the NOR parts list. By removing
> this entry, both mx25u25635f and mx25u25645g (which share the same
> NOR ID) will utilize the generic flash driver configuration.
>
> This change allows both devices (mx25u25635f and mx25u25645g) to
> leverage SFDP-defined parameters, enabling dual and quad read
> operations without the need for manual adjustment of no_sfdp_flags.
>
> Link: https://www.macronix.com/Lists/Datasheet/Attachments/8663/MX25U25635F,%201.8V,%20256Mb,%20v1.5.pdf
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>

Applied to spi-nor/next. Thanks!

-- 
Regards,
Pratyush Yadav

