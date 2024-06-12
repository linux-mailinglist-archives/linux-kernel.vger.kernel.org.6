Return-Path: <linux-kernel+bounces-212030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF07905A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4843DB24EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17C1836EF;
	Wed, 12 Jun 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALPCfw1m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BC1836D5;
	Wed, 12 Jun 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214722; cv=none; b=cptH8Uu1jfcAHvr1iclij6pjDhO00wyopWE5RVEDwY4aJPivfHQ4fYZ2yTjebW/psDp7Oi4+rI31y03ytPkm5AsIy3jvh4eKUaWMIz0lDBFSpvPCwNdM2IQDfaWzZVePr66Kqax3cOKMKQoFLluYltBmi3awPJlyil+ab2E2y1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214722; c=relaxed/simple;
	bh=GUySe7kOQ5O+5zPTwFjXrrUGkZhsuW1RT5+UVSqvC9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NqQdwxIH7Aq9aTh6MHKZ93N4UgxhBN3OzwV/+2EqBcs9uFDsysS0irYff9FHRgFxMT9t370ZCVdPKUQb1GsK4b2mM0n+x0TuY4xvsVQq3jVOiiYwFtdz6aCNSePuhIDNizGIVVi8HUnAuIP64/D3SjQrOqRzFyipIVL8VDf1rFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALPCfw1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6152DC4AF1A;
	Wed, 12 Jun 2024 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718214722;
	bh=GUySe7kOQ5O+5zPTwFjXrrUGkZhsuW1RT5+UVSqvC9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ALPCfw1mB4ZBxJsLgtqUW/NXWmqkaYgUHyTkHOIIBsxP3Q7vpqiKg2T8BNMyaAAGu
	 nC/NOiOXZUi2N1eV6vxbdK1FDlsqg6sA1c7sr0mNNr8cSFQn+FqSTTNgfPfN6RPwyn
	 NArM2caQla0pXUjX+j51//1c4obyhbVyYxnDFLlfO92kadKHYOibWsOkfS8rOSMli9
	 2bUOSuP853RysyoSU1YSfxBGxA/8JLaWFenhQxxJlRgbh/ugp77sZngxBXW71TIhyA
	 QJ8sTYRooleTdgEAjSJ3MXiD+f8xLxXs5sXSj0E9thdRYWSL0jiN7Dcl6YR8k3qWgR
	 ZqAuhstBcXDMQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240608-md-drivers-phy-broadcom-v1-1-f070f84cc3f0@quicinc.com>
References: <20240608-md-drivers-phy-broadcom-v1-1-f070f84cc3f0@quicinc.com>
Subject: Re: [PATCH] phy: broadcom: add missing MODULE_DESCRIPTION() macros
Message-Id: <171821471999.586907.11914023851963096437.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 23:21:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 08 Jun 2024 23:17:05 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/phy/broadcom/phy-bcm-ns-usb2.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/phy/broadcom/phy-bcm-ns-usb3.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: broadcom: add missing MODULE_DESCRIPTION() macros
      commit: ea09ba7653bb53252ed96ec524991c55a38bcd0f

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


