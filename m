Return-Path: <linux-kernel+bounces-190758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15558D023C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709B01F22131
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EC315EFC7;
	Mon, 27 May 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORzy+jZs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB313A3ED;
	Mon, 27 May 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818007; cv=none; b=Bj0ubb13XqvJuJTvvQcVetVooql0tK6SkoSevVVEGstkWniP4PolairhnG1z3i4oMU5xxI+7fOgD+baeKbtliDA+TUP8TUgtB9Y/9IUDOwbSjnygbUbB2O4VW9nR6xGK10dQBxjh+cb8DwX7GfuTvZrKGDzkLmXGSob/meJBt0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818007; c=relaxed/simple;
	bh=9iEM7rSZZ2Qh4u1OqsWD5mgRI9E3/rgrVS5BV9SJPDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXCBHyfbuK29YtOj5W8P28qizMEXT7f4ZkHu0wo41BsGEgLAuMm26Gth4QiNaF+bv4Ak8DnxhaMs4Ri7FX9Gq7XeXgWr11o4gz/EgLGNY8zk8XUM2i3UF6iReGMIZNhbvNNeTSNA1+P88oEYuWdGmkLvUHdvD2pdmrHvkOtXQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORzy+jZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA14C2BBFC;
	Mon, 27 May 2024 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716818006;
	bh=9iEM7rSZZ2Qh4u1OqsWD5mgRI9E3/rgrVS5BV9SJPDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORzy+jZsAxuR+p3jDy/gpGkXhI39b4zASbT88jeG2DGH7++HeVzQrQjfi3mc0Xrss
	 On3MnWt+3R3MJVqVRtwRxF5OFIn1J9VAZGXDnFjxTTeF/RBgTB6xoEOySXz/KP8wf5
	 Cz6agy8oMpggQqg4rPRHFHjAV+Qj1V3tA+LMruAzdRmz3iMo56CpugWt7CBcEMAVqT
	 7T0hmK1bXIGF1tby3QMN3ykeIrA3bDb1sBi/Rz8FLtdaGUABzKteWqIz0Vrfabh+bp
	 DHdfCZJudjl7bAK64Lr7Gxax8QkWT213xhLF2wPjnEV5MERIczLHqJM2bmSxp9OSUF
	 LHVGhigWPvFVw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: efs: add MODULE_DESCRIPTION()
Date: Mon, 27 May 2024 15:53:16 +0200
Message-ID: <20240527-erfinden-rhabarber-105943b7227f@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524-md-fs-efs-v1-1-1729726e494f@quicinc.com>
References: <20240524-md-fs-efs-v1-1-1729726e494f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=brauner@kernel.org; h=from:subject:message-id; bh=9iEM7rSZZ2Qh4u1OqsWD5mgRI9E3/rgrVS5BV9SJPDk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFTPDV79b+UBX9WEzpqsZNXebI44H52wUSn7tmhZhue CO+98bEjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIns12L4H/Zwq+brgK9200rl bG2mbcx7eTK66IQJ606PbHZBo31HWBn+OwhYP/522p7lQLqxkWao51m9CrOHja84DY9subZNJji BEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 May 2024 16:45:00 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/efs/efs.o
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: efs: add MODULE_DESCRIPTION()
      https://git.kernel.org/vfs/vfs/c/e14b2adc9e5e

