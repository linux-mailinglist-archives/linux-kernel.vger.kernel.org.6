Return-Path: <linux-kernel+bounces-190768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D098D0270
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CC71C2152F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177515EFDA;
	Mon, 27 May 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXSx4FMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58C15F30D;
	Mon, 27 May 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818304; cv=none; b=KAzL5avd6nVtTs/I/Sa//SDXM+yDXkObLV1lwdERWd3uECVlz2Bxi0m2QHZ2zR9F5qH3lqDjAQvYpPxo47yrMYkM2OLbxJT0LH+QcijZ54ryhpK3hf83yuRrRoFf0CmqxAq4h83Yy9CNfOyre5oPtR5PbPmVHJKKs9vIJ6V3o74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818304; c=relaxed/simple;
	bh=Isv9pNCDmG68dJYcDYRxbpANQJq8JEINJq10711HhoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVVMSDGUDy89Yue0QpSBh/ILCPNaeouIy12xX7iWoZSjEk+Qy00IwW3yp4JLpgX2Q0ef68xARZgCC/0/8O410cDI+2P4iZLQ03zMyNd9Dr2UqpQwzzCUdwvX+G+GrzhhKeonER2cqDT4HOcW/h6txkY65hDyKqluIwkDIOEw5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXSx4FMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0105FC32789;
	Mon, 27 May 2024 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716818303;
	bh=Isv9pNCDmG68dJYcDYRxbpANQJq8JEINJq10711HhoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXSx4FMGHyDi1GgHk3nZRGQHHPWrYfXQVMltYm3IxigDcJDIgKzhyH4lvgE4s4FLG
	 4gc8qhbSRWgM2RrVR7t5iVkxNbPyObOmltooF1Nga3FnDDpk9sffPC5fwe/G1BQn3W
	 bqyzw3NKdlPuyykbjA4zqzZL3P2VhW+Ov28JHdVlTsNywSY2kVRX/sLAwU9DOyr5pL
	 96QPXxufl2f1SvvBCitRkm+4VEXSyNyvtnrHSd8o6HDzEYWvnF8uwCSTAh85zKmAt/
	 9RduCD5yIcZ3S2BHQAbBT7p065FlSp5NfhB8vXDLg3pPFVlGx9fGFFBucSLGE6Uoan
	 0cG05RGTZC8ag==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Anders Larsen <al@alarsen.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] qnx4: add MODULE_DESCRIPTION()
Date: Mon, 27 May 2024 15:58:09 +0200
Message-ID: <20240527-harmlos-hauch-9f8216c158ef@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524-md-qnx4-v1-1-5ae060082e5f@quicinc.com>
References: <20240524-md-qnx4-v1-1-5ae060082e5f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=brauner@kernel.org; h=from:subject:message-id; bh=Isv9pNCDmG68dJYcDYRxbpANQJq8JEINJq10711HhoM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFTKx4Y9787GRAqVez/4pNMWduu9QUf8pln9r7M/uh7 NrPR9ItOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyUZjhn1bdV4s1Av8jtNrf iFyedSv5lOudkP6NTf+6PBecf1W/yZyR4cNem5OzNkl/cLmYe9t8Rkry/Xvz+GLr3u9e/Zr1z2v WXB4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 May 2024 13:51:46 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/qnx4/qnx4.o
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

[1/1] qnx4: add MODULE_DESCRIPTION()
      https://git.kernel.org/vfs/vfs/c/39a8d8c49645

