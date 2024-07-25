Return-Path: <linux-kernel+bounces-261961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE9793BE51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE227282655
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2C196D81;
	Thu, 25 Jul 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQlCe8K2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8A1974FE;
	Thu, 25 Jul 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898229; cv=none; b=S7VfTkkJfc0pWVhz+Bb4QoKUNugKZvUHxCU/PV+uQXXJLIcdHy1LywFZsvwXky5JnoJAV7sjLJlOOmgvLXePs25e/kdXjvnUjNXcoAWTeVx8L6H1yj1Dxa3ed9FEWrDMTpc0wI2WRsS/CM7Pm+4hjczSVlGKxeQYAuUNQZzhOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898229; c=relaxed/simple;
	bh=WpTveJz2uQ72NcBwM+L8L0cjkMDNEQE3cUYYzhYVg40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j72p2xujmaKwKfWjILNJyolItrZxbScSECxS/D+yVUaQkEvjScg76AqdpAbbDCHS+ZnPZMjdOOUJiIfAoItKlOg4xXd8g0TjDXd6h8DxAxhaNer1qDFVIVk1cbYITWMk6OT3jd3PnzGZalEJWyqSdpeFc5MA2AdKla8Ey4dfytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQlCe8K2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AE4C116B1;
	Thu, 25 Jul 2024 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721898228;
	bh=WpTveJz2uQ72NcBwM+L8L0cjkMDNEQE3cUYYzhYVg40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kQlCe8K23JBhmJd3GAH9faTP44B5LNm6ZG2vyCRyctzYhcd1iMdaceu8oaSyQlZhb
	 eTmd/kTcN5bDV7thu/KGehdOfHInZmZnLhKKVvaojAv7FGiTNXbh1U2LNXDyzXAcD6
	 UikjsLgEtmEH4X+3dV084YiS1z4LyK03TGVOk24YUJqiJsY6qP8Y/vBb0pHSy/c6JI
	 UkILQG/cedLqYVSueJL7hzDEQEr5gFdOuptinxr6ToVIgFjKWSglznYocZdlcY73n0
	 r4ZPieGwIM12EQKMb/Tstfxd+fkr73we5eHt44HyxnRaaH8u2MXU1xWhyu1vKqZglt
	 XJW+sixDeI2iw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20240711065140.140703-1-lukas.bulwahn@redhat.com>
References: <20240711065140.140703-1-lukas.bulwahn@redhat.com>
Subject: Re: (subset) [PATCH] MAINTAINERS: repair file entry in MARVELL
 88PM886 PMIC DRIVER
Message-Id: <172189822724.880563.13211216393820774590.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 10:03:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 11 Jul 2024 08:51:40 +0200, Lukas Bulwahn wrote:
> Commit f53d3efa366b ("MAINTAINERS: Add myself for Marvell 88PM886 PMIC")
> adds a file entry referring to drivers/regulators/88pm886-regulator.c,
> but the directory is actually called drivers/regulator. Note that there is
> no 's' at the end.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: repair file entry in MARVELL 88PM886 PMIC DRIVER
      commit: 9da8a941a7600823250ab3e9a2256eee5f29be34

--
Lee Jones [李琼斯]


