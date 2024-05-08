Return-Path: <linux-kernel+bounces-173332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E58BFF09
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9747A28C23D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C87EF06;
	Wed,  8 May 2024 13:41:57 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85579DD5
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175716; cv=none; b=WE89P3VxoY6cy/6MCu8ncKMLLhwSYpMPTn/d+vvrVwGTx7U6MdvvoU5iGzPCGGVo9wever7UF9pv17y2DMwYMHazlpMo8gsK0AQRB14uaaVkXgpNMtAPVcna98jEF24b+gFSv3KpNYMMg5u4FM0UJOeU0FnH7JTlcQqZT89q6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175716; c=relaxed/simple;
	bh=VIHkQgIeEvqWQ9GKN8UGkjOVfFTa6PDCqJsCFZiPlHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Exsg/Q/a1uWQdVRc7ATrCLc1Lba2Y6hPcQvDi6/zbtjGJQR+RIZsuJYARFIQpb0R0vswH2Eyy1Bmr1njktjKSXsJo+Gvg6aeFspGZ/8O6wsfadYdXZO4dfY0V0YB4sczAqOhh/7bLDQWn7JwdOjTLxrFzRL9e/XTJ8m1O/aV7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXJ2ZlGz4x3j;
	Wed,  8 May 2024 23:41:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, Kunwu Chan <chentao@kylinos.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126021258.574916-1-chentao@kylinos.cn>
References: <20240126021258.574916-1-chentao@kylinos.cn>
Subject: Re: [PATCH v2] powerpc/cell: Code cleanup for spufs_mfc_flush
Message-Id: <171517558556.165093.4418850718054989946.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 10:12:58 +0800, Kunwu Chan wrote:
> This part was commented from commit a33a7d7309d7
> ("[PATCH] spufs: implement mfc access for PPE-side DMA")
> in about 18 years before.
> 
> If there are no plans to enable this part code in the future,
> we can remove this dead code.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/cell: Code cleanup for spufs_mfc_flush
      https://git.kernel.org/powerpc/c/66d8e646e8e78ea6088d9f6b9465e211566b5133

cheers

