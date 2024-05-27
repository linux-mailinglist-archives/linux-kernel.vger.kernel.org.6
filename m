Return-Path: <linux-kernel+bounces-190761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC6D8D0244
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E21C2352F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EE813A248;
	Mon, 27 May 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfiZ7GT3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A3715EFA3;
	Mon, 27 May 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818274; cv=none; b=NpXLz0ASte59gSeNuerp2LhSUgLh73FlRz9pDvyQFF8r+9nJqWNIloJb7y5s0hQdlRRj4AJtROjTemVmZNF1tnvXEK1jhuh3k4Z9rBQVdJ1ImWBpmnI0+VP+mh/8zeBcf0/NqszsGWeZAITIFhqdW59rqhCGgM9JPn8Db1jtjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818274; c=relaxed/simple;
	bh=JC8GEz8G4a3fZScQnNQcIJtoiYGxExg7xk7Tj6v29Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4GCM7KnITurT1Rl+Kc4UqWCiuf02WicoY2vokcSwGj5SkVN5Mdw4hEczBTLnYjPczgEhYvmZrmoCU4oPRLGLzmXLC4p1uT7NfkhPTUfDngRD+1B1GxIIy0LKjYo3LNm/fjiGl2w9iRRJXaNLc2z9eW0A/bJVFKR1vq9zkKqLkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfiZ7GT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F558C2BBFC;
	Mon, 27 May 2024 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716818273;
	bh=JC8GEz8G4a3fZScQnNQcIJtoiYGxExg7xk7Tj6v29Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfiZ7GT3yPZb5/lSB+rUhMIj0no0ssXp/rEp2+ocEues+MJvrERaPoTPXcBygp6v+
	 PLOL7tgisRKkxXTH2ToOxFdXyaegydRbFuX9n0PWUqJlLPGwNiEECN4FXS4Sr/8+RM
	 ZwHGFUnSEnJhCSZ/Y2eJppRljdlPAK9YQv/nKSdO3Z/7fgfqmjl9tuLxmOdUNhOXUz
	 Xtq0vtHC1QR5CqE/3Mqha3Zri3K4cUAM5UISx116eQiOX7SlbujUeiUMt20Ffqb5t4
	 6e67mfH+hwLA/WBQdjVALMioh9m0/u07FZbIr/lbcMZbt/k9nkRigc3px9ziTk9Oum
	 NYeT+LZmyVK2Q==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Anders Larsen <al@alarsen.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] qnx6: add MODULE_DESCRIPTION()
Date: Mon, 27 May 2024 15:57:36 +0200
Message-ID: <20240527-regte-zierde-b0b466343fb5@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524-qnx6-v1-1-cf3b9de68347@quicinc.com>
References: <20240524-qnx6-v1-1-cf3b9de68347@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=brauner@kernel.org; h=from:subject:message-id; bh=JC8GEz8G4a3fZScQnNQcIJtoiYGxExg7xk7Tj6v29Yc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFTIzmi+44+z2jc6Hr0/erp32SbfLY3274VfZr18Prr PGnrxZXd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkfDfD/+yT/rL6TebGxhe3 RWYGeOy8Kym/O245t6eRQ/uF89WtPxn+GbcZ+Kcu3VKdv/FzpE79d0O/mmdTxGv4VO9pO7ZxpfI xAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 May 2024 13:52:52 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/qnx6/qnx6.o
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

[1/1] qnx6: add MODULE_DESCRIPTION()
      https://git.kernel.org/vfs/vfs/c/318f35e4ad61

