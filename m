Return-Path: <linux-kernel+bounces-238291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A275E9247F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F6DB22F14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2875D1C68BB;
	Tue,  2 Jul 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG9Tn4vy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE441514DC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947789; cv=none; b=WDXtKPhODsBzCGO7op0Zc9yzbGfr80FnKnJI15PAuSe8fRlmfoSFAS1dmU6826ttBF5/AYyb01T7FzmiwpSJCVcm6C58hEdMbBtefU5TwY1s81M9QY5tUyLyPywFR0NZaE1aqiK0nvXSYJoS3HFAX0CwBoQZ/HquWWWr6+mJNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947789; c=relaxed/simple;
	bh=2b8l3iGZHWnlzOU6brw+H+HzDuHoHsjZo0MAPl5t1bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4RZZBsSZgiAe4ROHYWbFbTYYBsbVlTtkMe6Xn7ewTtClfQF5wLPYPfNWjiaiSUocYkT6FrzP7Q1etl0enwE3C6T0Vn/Y2R2szDlURFtJI/57mCPXL999hWI8o2gfHwrlZE1Jx62XIuLCKDI2vmh+4ord3f1p6PRyB0H/fJHtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG9Tn4vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61727C116B1;
	Tue,  2 Jul 2024 19:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719947789;
	bh=2b8l3iGZHWnlzOU6brw+H+HzDuHoHsjZo0MAPl5t1bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WG9Tn4vy+/CdHv1LJ6xaqI07IX3+WzHMUz9+chHqkxJSFhqJst9dMCUetLtEvoZRp
	 D8oidooit24BoK02ytUCzzDsix3Gi4OOlYOyrxUBqtBdU3HbKa7mfqqR18BoR2QCTe
	 C4egM5OAcGw4Ece/8DlnfhB6pPzxX4jrpLJJL5oJHeK1G9QtKvX3k0EAooO2Ab0ceU
	 5OQ49uWrqFwTZ/n7pGV/MFjZzjB65w0QOhOjIepTHlJ/IYllCL/i8aDyjolKPRSMPq
	 Dr7VNwOt/OzuG1O9Kta2Kxre6H46SBnyG1CDNJxouL38EMphcLBJ5R58YWx/RCeSyJ
	 6zdbSGZ4H0jbg==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	Chen Ni <nichen@iscas.ac.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Convert comma to semicolon
Date: Tue,  2 Jul 2024 21:16:19 +0200
Message-ID: <20240702-zielgebiet-auszuarbeiten-0fb83ef9a9fe@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702024055.1411407-1-nichen@iscas.ac.cn>
References: <20240702024055.1411407-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=brauner@kernel.org; h=from:subject:message-id; bh=2b8l3iGZHWnlzOU6brw+H+HzDuHoHsjZo0MAPl5t1bA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS1BLGFJn9Y8fqsQcq+59dEesIjVrusmL9XOqmJexk3d 6jsWr70jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMmM7IcPyQhIPbr5cFPW/2 S8y6ntdnMePgEdHAibsWafD+N/l3eB0jw4XaTTdsJ79doS8gb7vpa/tPQZ8XaZqpj99N3vhjxUP lnSwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 10:40:55 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] afs: Convert comma to semicolon
      https://git.kernel.org/vfs/vfs/c/ecffa92f8e82

