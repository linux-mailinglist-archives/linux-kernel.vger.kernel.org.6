Return-Path: <linux-kernel+bounces-319449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36C96FCB4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDA0287789
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDD81DA0E1;
	Fri,  6 Sep 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiFb6S7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715901D9349
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654502; cv=none; b=iaU3OjacbLd0Dpd7lrxee/i7LsWYzfLu349GR8S79a9IMHBcrYDoK7Pb+OPY5jtQ4T5eMJZ51XfsDc/hauWGNQtpe1vdF4rVpfcXsUxsBE803x80s9Wo032pPaKmjMw6fMJtKsio6TnlqX2F6zfhRLO5HAfmSUIJn1q3O3p9d+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654502; c=relaxed/simple;
	bh=Em/82/sxQZ2ZmxxfBQmS3rxR/qbFW9jvMHw+SAgGsQ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WB/ntQJTHiabKZbhy1SGa56Jg8RBg4duPS0L8BOdLvvTsIo/m9lPtV0OMzBdmb0x0qEp92qxamkankBUXy2JnFp76nqD/U1YamEBepFfXCzHCRRMVm6JTTP4m8NDOTqpPxX9nIhOZCAajV+ZuSPfHdyGxhLpe26ixslRfz7uFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiFb6S7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51445C4CEC4;
	Fri,  6 Sep 2024 20:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725654502;
	bh=Em/82/sxQZ2ZmxxfBQmS3rxR/qbFW9jvMHw+SAgGsQ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QiFb6S7uT/pHGuLOCZ4rpis9UhTIbgvhbTmokCJO6X2cGbE7lJFNfnlpkjh6/BnZt
	 MSq8AIdWglyquZjSQv925ElXx8ENy1RnQabhxqbof0UUpy2Sysa1boGawT6cc2exLb
	 6GDgxEteXcIl3FVRglQBUbZQLaCJBWFzaZhD8DKezEUlRZ/ZmRUJKqjYPS41QCGa+h
	 qNY0ebEsKafMW8Kg+oYmBhYjMZ84+hYo+Tb4Od5uqeeSLOg474PNMQ3/wdmgIEuWxx
	 iygURoNYZQhlm3XLCDhSh/PhxtFdy0UPVFij3kUsYdokuQlczUo8VBmCxJgHzdJ5e4
	 5pCZpj1kIWYBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719573806644;
	Fri,  6 Sep 2024 20:28:24 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.11-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ttet3rz9.fsf@mail.lhotse>
References: <87ttet3rz9.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ttet3rz9.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-3
X-PR-Tracked-Commit-Id: 734ad0af3609464f8f93e00b6c0de1e112f44559
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a78d7dce1e71231cef671ccf5ab48b31606fe352
Message-Id: <172565450306.2515438.2687222332316048321.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 20:28:23 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, nysal@linux.ibm.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 06 Sep 2024 22:07:54 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a78d7dce1e71231cef671ccf5ab48b31606fe352

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

