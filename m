Return-Path: <linux-kernel+bounces-313276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6F996A2EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5DD1C23796
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BCA18453F;
	Tue,  3 Sep 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBxV9SYV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4A1AACA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377850; cv=none; b=HqkRaDmjUetmsFVxf41n/H7CRK7jPu44NV2mafuCDNZLT13Gp0BldUVP/nIj6MU/RzGO3NF3mLN2zryOqrI19x6gq5NOX/lssP/sFZJJiQCMG5tIYnzftUigZxp/KtuclOs+Yc7UP5ybflf0pi/84/N/QHlR7EWw1wPEj8ICQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377850; c=relaxed/simple;
	bh=R25orLkS76QCVi0ayOPisTBiq9jp4GgoHjqmqCL8wCo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lyyu6TZdyPcLiPR19mKFaMu66clUprHKSx6lzx0BNxCQVbWpfkN5/jWaSkxReqi/HmSa0NkdQv6jXp0WN0jNyRzqPl3iB5GBOrvi/9ym2PePz8DSs8RUaz4Yeexelt64Sel4N7hKzztF5ldNnWcY0Ez4wy95cScDqIC1awcLuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBxV9SYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E69C4CEC4;
	Tue,  3 Sep 2024 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377850;
	bh=R25orLkS76QCVi0ayOPisTBiq9jp4GgoHjqmqCL8wCo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PBxV9SYV87W84fhSfncoI0XS/WdzkSyopG1chWqkZB/8xbzqQveLf8xN71e/3je6Z
	 XO8lOMRJ6TiS3wTCGqWkjqtAdrdU7EoF+Ky5jlSM/OIQevb8RyoDNwBQSWpQb9tEF8
	 vOI9saM7freq1DEMiy8w7fBAjxgU2LlrPQ1LNXLCtq7X2jqu2WJGvGJ8f4I69ivXeW
	 gj+/eVSFPvER2ROQvpUbGuwodfY4p8Eig8krdQ031ojJdq7Flr9OLJvpqvuONwSrSh
	 Ob7K5jH5hI8DnEDdNvemacX6+ergffxJkDYp4cUzZp3hYsjfZw88AGUgOJsNUcxjle
	 fAHF4TI2jX+JQ==
From: Lee Jones <lee@kernel.org>
To: manivannan.sadhasivam@linaro.org, cristian.ciocaltea@gmail.com, 
 lee@kernel.org, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240902085019.4111445-1-nichen@iscas.ac.cn>
References: <20240902085019.4111445-1-nichen@iscas.ac.cn>
Subject: Re: (subset) [PATCH] mfd: atc260x: Convert comma to semicolon
Message-Id: <172537784846.1279892.15340290228913825891.b4-ty@kernel.org>
Date: Tue, 03 Sep 2024 16:37:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 02 Sep 2024 16:50:19 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied, thanks!

[1/1] mfd: atc260x: Convert comma to semicolon
      commit: d7548a14ed7c45edf2b73e0c527597d2709739e5

--
Lee Jones [李琼斯]


