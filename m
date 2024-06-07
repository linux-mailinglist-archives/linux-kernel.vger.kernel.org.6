Return-Path: <linux-kernel+bounces-206567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA71900B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFA31F2160C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DC19B3F8;
	Fri,  7 Jun 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h13+vsKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19BB19B3D4;
	Fri,  7 Jun 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782444; cv=none; b=G1aXa092SOzt5XtnwAzkAjISqsx9+nMwo5bPPilf+3GMwwUS2GNvJzNp+cLbpzpiLRG9GBZTPLqX1TktdiM7eXV6YnRPZkmTJwobANEJoZvVdhlPCPtteSJ5scNHw0hOh+3NMT4DAXm3qw2vsUWV+6bBGCYIibKU2uv9Z24rSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782444; c=relaxed/simple;
	bh=lgjefLL5Z3rP/rbNsFuurSusuD9paPVfZo+z2mjiAtg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZpOb7Ma8BCU+HSVAwNHvWAqqUSurJ7PBfjgAC+vnZVAOUSaUndsNEAEeKFH42PPeCpUrLZpJQvhTWBX2MfvUjpuz3kqRaafPDWuX7k/HVr1gXAjTNRjs0v0jjsC/4TyRUxWeDWU/o3dnH8UQ4QLuSV64Rf5ZyRUA+Yi1jq5Dflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h13+vsKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAB2C2BBFC;
	Fri,  7 Jun 2024 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782443;
	bh=lgjefLL5Z3rP/rbNsFuurSusuD9paPVfZo+z2mjiAtg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h13+vsKPhK6RHc3TEny30zmTeVjF/hJx9ANEnLNPfBEz59J4vtrpKob1RgFjInvjH
	 fHJsb+quuBnBrKuhxr/3IWzyFMa1fte7OfOXIv1M56dDSQYGwhX3eQW0B0azrXBvYd
	 yp7M9q/e/6v85mA5t3P82oIWQ4uu0Q21CgRPy7tPgx4xZeF/aLvRVNPQYgrzVWbKic
	 34W/HKTGLdT3LuTxC4cZzALaLkJ9E/YRGBW2Sx/w20K24+IgQsUkJh/1RcI7fWc+yw
	 7I/M8adDzFVowGzTPvVa161ao/KzFSm925Q1s/YnQUXTYa1UB+OobZDoFtQrrONhpW
	 AHQBarZbYO/Ng==
From: Vinod Koul <vkoul@kernel.org>
To: Sinan Kaya <okaya@kernel.org>, kernel@quicinc.com, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240603-md-drivers-dma-qcom-v1-1-d1bd919352bf@quicinc.com>
References: <20240603-md-drivers-dma-qcom-v1-1-d1bd919352bf@quicinc.com>
Subject: Re: [PATCH] dmaengine: qcom: add missing MODULE_DESCRIPTION()
 macros
Message-Id: <171778244108.276050.8818140072679051239.b4-ty@kernel.org>
Date: Fri, 07 Jun 2024 23:17:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 03 Jun 2024 10:06:42 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma_mgmt.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro, using
> the descriptions from the associated Kconfig items.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: qcom: add missing MODULE_DESCRIPTION() macros
      commit: 8e9d83d7228f663ef340ebb339eaffc677277bd4

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


