Return-Path: <linux-kernel+bounces-174020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D748C0939
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67518282D9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D0B13C8E9;
	Thu,  9 May 2024 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyqeTfDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E513C806;
	Thu,  9 May 2024 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715218754; cv=none; b=Pd5OlxAUN7SLpCEPGp9cz8wdIDhN6f9uE7QpGchWkcbFusn/qXTXei+etVvpLpJdzpMdI6GOTNCm+befCxROCzi8c5Q9F8O9413nZPugWxkWhfzVhlhJppVdSjPlE1KEluemTzJbGbaxs5IR7fVA0YPc+2/GQMV4i1uOdRBa9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715218754; c=relaxed/simple;
	bh=C59DV07EAbIh77RRqSpx0oC1Y+VhMFF3FPzCuCWRsNY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=tOcSReQXtqqdcI2IIiwn0lSMPoFZBrP+VB/pIcl8qvzkrjxV5BFdgBQ9Hl6Kha57UEBuwKLyzXNuz1oJJdsCZ0Zpifbkk63ly3zeIHDJ93XjOfs3vufg5l5jZEzXeHPbURJdwr2DwoTBnRsNxOEO9qtouxKJu8NWBFpiR8/Ssj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyqeTfDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626AFC2BD11;
	Thu,  9 May 2024 01:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715218754;
	bh=C59DV07EAbIh77RRqSpx0oC1Y+VhMFF3FPzCuCWRsNY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jyqeTfDuxumlqe0iaFrrMby2E+2aU4/aySDp55xAR49+VmyATJZDcXj3vNKuqLnow
	 5GxrPaRMPq0cyV2KpvACi127L3HBvCCmZ4A7DBgWp7W32Jyo/2ZxfRRrCz3L9Y2VDx
	 8rRCOhLKGdrzublp7j++fu4LwlgFXxtsbXW7jL569LHNDENDzy2o+UPZ0QZa34eBpu
	 o7Zor/vwSsWOXQiRLeXUgNHSxmo5u71V7IU+bMacuMLCpYyt+oTymJM7SSpSpWWgeK
	 EFVFMrIcwmtBYaZcYeTm0+IPFVt+ARs0S9k16yJrjUFmgoJpfnzircTjvpERFMi/TM
	 dCOESj352OGqw==
Message-ID: <cf80c2e6ab5aee23c4425419324bca32.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240508-unabashed-cheese-8f645b4f69ba@spud>
References: <20240508-unabashed-cheese-8f645b4f69ba@spud>
Subject: Re: [PATCH v1] clk, reset: microchip: mpfs: fix incorrect preprocessor conditions
From: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>, kernel test robot <lkp@intel.com>, Daire McNamara <daire.mcnamara@microchip.com>, linux-kernel@vger.kernel.org
To: Conor Dooley <conor@kernel.org>, linux-clk@vger.kernel.org
Date: Wed, 08 May 2024 18:39:12 -0700
User-Agent: alot/0.10

Quoting Conor Dooley (2024-05-08 14:33:24)
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> While moving all the reset code in the PolarFire SoC clock driver to the
> reset subsystem, I removed an `#if IS_ENABLED(RESET_CONTROLLER)` from
> the driver and moved it to the header, however this was not the correct
> thing to do. In the driver such a condition over-eagerly provided a
> complete implementation for mpfs_reset_{read,write}() when the reset
> subsystem was enabled without the PolarFire SoC reset driver, but in the
> header it meant that when the subsystem was enabled and the driver was
> not, no implementation for mpfs_reset_controller_register() was
> provided. Fix the condition so that the stub implementation of
> mpfs_reset_controller_register() is used when the reset driver is
> disabled.
>=20
> Fixes: 098c290a490d ("clock, reset: microchip: move all mpfs reset code t=
o the reset subsystem")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405082259.44DzHvaN-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202405082200.tBrEs5CZ-lkp@i=
ntel.com/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-next

