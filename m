Return-Path: <linux-kernel+bounces-212982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4F3906952
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D772869FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4FB141999;
	Thu, 13 Jun 2024 09:51:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E61304AA;
	Thu, 13 Jun 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272268; cv=none; b=V7ThuWc7co6FtzSs8BCnXCv49yjHUeWK65BZKNeVeML6mB87OMEZzF9PTS8OZKZ/2Mtllh69sQwJYNlz3CZnzPTZ/4o5/ckZrEvoc+HqShImlgNFXYutIMY6ShyWs3BRo7leD+AdAg0VYSFn3yPJ4yRy5tLUe7rt3enEkYCEWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272268; c=relaxed/simple;
	bh=P7sRem6aJSQwbsJkxebbgq+IQcCxrUaIcOl264eZsa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psS62ZzztROyAM/C5ZXt0amRdPGivoprWgEqME6u8jHGF+nApRyyGZxV2BvYjkKASUuJj9clZycHN+nNZaC4WqF5TCXJIIvrANib78QzWkLwAYZDB8MZjtkawtw0XsHdsmlVtratbyD0NJ0w73KY+6unqtCzdYpXCYJAswcQuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A29EC3277B;
	Thu, 13 Jun 2024 09:51:05 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] kselftest/arm64: Fix a couple of spelling mistakes
Date: Thu, 13 Jun 2024 10:51:03 +0100
Message-Id: <171827226019.47137.541635924892576810.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613073429.1797451-1-colin.i.king@gmail.com>
References: <20240613073429.1797451-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 08:34:29 +0100, Colin Ian King wrote:
> There are two spelling mistakes in some error messages. Fix them.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Fix a couple of spelling mistakes
      https://git.kernel.org/arm64/c/963c5d496822

-- 
Catalin


