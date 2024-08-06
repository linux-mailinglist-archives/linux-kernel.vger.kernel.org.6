Return-Path: <linux-kernel+bounces-276523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4287D9494E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02241F24F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC9D38DE1;
	Tue,  6 Aug 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM6gUj4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5818D63D;
	Tue,  6 Aug 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959741; cv=none; b=mySZRnawzHf1jgZYnawAOqrg28/LbspljPpLxYExdkYP12H993hDyl8DpPx4GU0qPizM2BqbkV7h2ttW9MY97B3HcwGRMV+SJWrRT67lPz7O1NS1bDNkgIjkvhSKdaA34+CHh9tqqinwq61ujhDf07SlnNes/S9BzQI3TulZdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959741; c=relaxed/simple;
	bh=/sv6gYkp7yTjivrZVJtBmBg2T3ZWK+a7WwzkedgCgi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJawRnvpfdyG1+S776BHErJICq7BHekbvovoZcdOl3d4xc5Lew8fd3U5bQcJrE7XEsKKckZdUy9QHrXvHknJWYfFUx4LJ8dyu1SX3aIuqriVWmvWm+kd45akaPHdKdeM5tgN8x5ub//2j8zx+51P//hXFg1jId7SytCztdHo1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM6gUj4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20337C4AF0D;
	Tue,  6 Aug 2024 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722959741;
	bh=/sv6gYkp7yTjivrZVJtBmBg2T3ZWK+a7WwzkedgCgi4=;
	h=From:To:Cc:Subject:Date:From;
	b=AM6gUj4zDo8RBtW/yokd4Wp3CxllTGy0yjxcNIbFloc1CEQc8GSrusZ/bNNJCEZ11
	 BzxwBuxP3TNzIZ/+i9lNKX25xgFeVpivK4mR4ZZX5NB19E4e+DVlGscpUdHq4lBgBz
	 w3VuODDqaCYQ8UnNzygR0BIUbn1M1vqk1Wt43pzA7Vmbdmy9HopaQRBKlW9ryvZ/eJ
	 tp+8FsBCXSU0MUf+PUJA8S5Z9ftkcP7Ub3nOnKai5Tv0AyqI5QTnwmoecJ0KJ45qAW
	 dkPMhAajKPvKsCjWnqZnE6Swpg0xdW3u8CQIcD/NZQY2mVW44H9ezUHAB0ERXjWt2E
	 QzamZ+4dVd3bg==
From: Kalle Valo <kvalo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
    ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: linux-next: request to include ath.git tree
Date: Tue, 06 Aug 2024 18:55:38 +0300
Message-ID: <87ed7163yd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Stephen,

ath.git is a tree for Atheros and Qualcomm Wi-Fi drivers residing under
drivers/net/wireless/ath/. Jeff and I are the maintainers. Over the
years multiple people have been requesting including the tree to
linux-next and finally we are biting the bullet.

So we are requesting to pull two branches from our ath.git tree to linux-next:

git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git for-current
git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git for-next

for-current feeds the wireless tree and for-next feeds the wireless-next
tree.

Because our for-next branch is very active one problem with is that the
chances of having conflicts between the branches is high and that would
be extra work for you :/ Do you have any suggestions for this? For
example, should we create temporary merges for you or something like
that? Just for this reason we do try to keep the number of patches going
to for-current minimal and only take important fixes.

Kalle

