Return-Path: <linux-kernel+bounces-182355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834048C8A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7BB283536
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE413DBA0;
	Fri, 17 May 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahssRdDg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86213D89D
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963773; cv=none; b=DBdax89d9xbPSaAZ771GStEuJ+ayFKphTso/vM8Y8+Tg38girV1sG3ZIY0NO7AFqAnHkiMnSY3pVWawhmFT7Uw29gyJas0BWkWV8ku3aJxl9/i83Nx2Sw4EQcdor6s+UQ+LS5vehMeX0QZgiE0aD6+tPT+nBIRlyA17VdR6RKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963773; c=relaxed/simple;
	bh=SA6WO6wNzW2Iok4qw34x8REiV/41ClfAvnMomEMrciA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BlbZ0tUc1f4F/Mj0Z08Sf/422CzbcdJ8F8DvRuLquqhyqIIa+P43SyLUVwdXMVwIUAKFlrcKfKvO8nc7+gwRLRMdOdxpL+IvfmLpyTE04pUOjUL0hymKpNoYIhHZfxZFqIOQ/0PCKd3M9ZUIWxTO86Oa82kZdCg3TGuIKvdlamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahssRdDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA46FC2BD10;
	Fri, 17 May 2024 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715963772;
	bh=SA6WO6wNzW2Iok4qw34x8REiV/41ClfAvnMomEMrciA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ahssRdDg4ghSC6x+Gl5lUorgLx9jf8XwCtJI5toNyEiXwWwKQqlHz63GVxQH85fwR
	 ktc74SrUobqjqWQeLQezEt464xxohE+FGH5XLZfQNnKCE6FxeEgYpMDeca4hT+h+Py
	 UxOBEHttEfl03r6xcJxGkl+hrBkNmK4ORCR6Hkalj+gN3rGFadDBw8DkCcbFXL+4VV
	 qPCcNRDxA/0CLxTxMIQ9mL1Bhx8MLsoykbUu73XP3SVLrUvaFSGvp2q1k+VenHMS1t
	 MF8301CHcUPq5sjiU1KaUWThnvmTHr5n9mstqtZENaueaD2E7e58wE2SuPhPedmvsf
	 PCIf7+7iSJvmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA764C54BB2;
	Fri, 17 May 2024 16:36:12 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.10-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <8734qgwsap.fsf@mail.lhotse>
References: <8734qgwsap.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <8734qgwsap.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-1
X-PR-Tracked-Commit-Id: 61700f816e6f58f6b1aaa881a69a784d146e30f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff2632d7d08edc11e8bd0629e9fcfebab25c78b4
Message-Id: <171596377280.8029.9881035055421932996.pr-tracker-bot@kernel.org>
Date: Fri, 17 May 2024 16:36:12 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ritesh.list@gmail.com, chentao@kylinos.cn, mahesh@linux.ibm.com, lidong.zhong@suse.com, nicholas@linux.ibm.com, bgray@linux.ibm.com, sfr@canb.auug.org.au, maddy@linux.ibm.com, matthias.schiffer@ew.tq-group.com, bhe@redhat.com, masahiroy@kernel.org, guozihua@huawei.com, aneesh.kumar@kernel.org, ganeshgr@linux.ibm.com, joel@jms.id.au, sshegde@linux.ibm.com, colin.i.king@gmail.com, nathanl@linux.ibm.com, prosunofficial@gmail.com, arnd@arndb.de, thorsten.blum@toblux.com, groug@kaod.org, naveen@kernel.org, nathan@kernel.org, christophe.jaillet@wanadoo.fr, bhelgaas@google.com, andriy.shevchenko@linux.intel.com, hbathini@linux.ibm.com, xiaowei.bao@nxp.com, geoff@infradead.org, rdunlap@infradead.org, ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, sourabhjain@linux.ibm.com, leoyang.li@nxp.com, yang.lee@linux.alibaba.com, linux@treblig.org, vaibhav@linux.ibm.com, ran.wang_1@nxp.com, linuxppc-dev@lists.ozlabs.org, jsavitz@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 May 2024 22:12:46 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff2632d7d08edc11e8bd0629e9fcfebab25c78b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

