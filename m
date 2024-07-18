Return-Path: <linux-kernel+bounces-256729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD94F93529B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6706F1F21C52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A240145348;
	Thu, 18 Jul 2024 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpHoiS6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FDD12B94;
	Thu, 18 Jul 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336526; cv=none; b=JcSSmcKj+eY6sQsZC28meoKoHcrabhzPc3LETIHALf3P6Pkfr+FwGwIxX0qSkpcESPi1V13p2UYDOckxOJqEwlicSHCTXZ7AB5grajrKy3GTYFW/vQNLau2nIoNprNXqF2ysozIAVGL+0u76CTjXilDz2/3tMzYCg7YUXrlqOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336526; c=relaxed/simple;
	bh=2tmsuB8807vM7DRg1GCoBkXXL08qmyyj7gTlWqJGv3s=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=IEVjYB5xeHjnSc+IWbzIFXEOaE6YJyfTbPzeonJYAuZfdza7WN/75jEwWzBongWCXItdeTWiOEL0rIoYjX1JWyr+TjWTYnWuWy3BLxoICdiWOOKczJW7BKJWIlZ7bWy4YgX4prDSWUUQk5mr0aY9oGL/+NNqWN1QZ7OJpJXt+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpHoiS6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BC1C116B1;
	Thu, 18 Jul 2024 21:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721336525;
	bh=2tmsuB8807vM7DRg1GCoBkXXL08qmyyj7gTlWqJGv3s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=lpHoiS6YoG8nLkHzxSY+eDKZiD/xlfaTv18YroF3GssL6ivKB9rwSnjTRyRsYm0pQ
	 Pp3+luEQVTZKQDANJtqiV1fZ4qTTYTXnLLy5mTz5M9K1AQCuYbJXS2PR4lutqleT8D
	 Su43YtGfwiWt3XWpTdBKizNKwr4yTW8W7S1ZJMBc32ZLfgGdjc8hB5cfNOld6jm4ls
	 NZBAY4IznidPV1b9rjVLlmUVEksPfnkUlNDrfykLPtiJHrrrvPS+HOCEmNjoiZV9ut
	 qkDGbDh4tpsj7sUa1H6N8t5TtJnvkSnliouogiTq70kSGxcnyoBpCpGD1UBc/fzRQs
	 0gmG22CYCSt9A==
Message-ID: <a3da2ff289e89042956e43281d43283e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com>
References: <20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com>
Subject: Re: [PATCH] spmi: add missing MODULE_DESCRIPTION() macros
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Thu, 18 Jul 2024 14:02:03 -0700
User-Agent: alot/0.10

Quoting Jeff Johnson (2024-06-09 17:40:17)
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-=
controller.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/spmi-pmic-=
arb.o
>=20
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---

Applied to spmi-next

