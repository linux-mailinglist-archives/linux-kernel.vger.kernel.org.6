Return-Path: <linux-kernel+bounces-222320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF890FFA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A981F21E98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD6B1AB526;
	Thu, 20 Jun 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icowDgyR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0A1AB506;
	Thu, 20 Jun 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873603; cv=none; b=grcwOa75DJSk+Ifq4ch7++5e6ijkiaQ+iWt83truEjwaWWnrpCAU5Vtt3bYeN2BkulWZchjFdzvV8tsomIxWCmc5FRYN/ildKSUzNgJA8sQlArg+53BErt0Tx8OqbjTCFKG65cujYwWkHPFsUaCV61xtOxK4Sn0deUVrZPyO33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873603; c=relaxed/simple;
	bh=l1RWJ8Fe3bejgKq+UazEidW0lPq5gmE0FU7WcCFsUD8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EYT/5XohBKSyUqTkWFOyCNNmz5dXe6MwGoceYLqvAP7ZNAgz3nvEfGkrmJjalGKyaBc51R/xJ88VsTZujommC21H88whF0hTzXriyLKihqjscqEs8F8YykjiiuynuH3OP7TPKOkKILJAahU7make2MLI6/4lU+AcXQ0vQUS3O/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icowDgyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF59C2BD10;
	Thu, 20 Jun 2024 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718873602;
	bh=l1RWJ8Fe3bejgKq+UazEidW0lPq5gmE0FU7WcCFsUD8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=icowDgyRC0rXLMcbMd4Z4i/xvZ2tdi5RGhCfvD7zRF5C/nst/8KDQ2L1yN7FDlVLa
	 cXHZ7G2p9rqtPFyk8lP3H1XUfCCjMw1b+b2hsFukU1AInHabejgUmPmaq8/Zw2zu6w
	 YWAbJt3yxq0keBwHRv2//RrNMyiB0OUcw751+G66wWRk+jIC37qvn/TIg9tQHMCz7v
	 VgSWEBE23O9A5SNBh/532qC4jpDV4R5GxtOoUdDql2BXGyy6NSIA/z4QFHdp6saGVk
	 C47Vh5E+z6/+E+L3FrBSuUdtasC4GSNr42T7fovILiKJcnX4Aqexyz9GifjcjhCev7
	 jL/QEGJasYIHA==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240619-md-drm-tests-drm_hdmi_state_helper_test-v1-1-41c5fe2fdb4a@quicinc.com>
References: <20240619-md-drm-tests-drm_hdmi_state_helper_test-v1-1-41c5fe2fdb4a@quicinc.com>
Subject: Re: (subset) [PATCH] drm/tests: add drm_hdmi_state_helper_test
 MODULE_DESCRIPTION()
Message-Id: <171887359991.3857922.6238282449475389694.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 10:53:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 19 Jun 2024 23:29:02 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_hdmi_state_helper_test.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


