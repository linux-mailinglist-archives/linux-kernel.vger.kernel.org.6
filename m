Return-Path: <linux-kernel+bounces-356813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD851996716
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE72E1C21908
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3518E76F;
	Wed,  9 Oct 2024 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDrtm9jP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B318C939
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469418; cv=none; b=ulpBDGPZw3Xj2QgMxf3QYw/oL4V4+qHrv4WE+1CHJdTALe6PdOuAwE1kYPrfcsPnif9EvZjukGkxLyNKQYxq9T+Y4tYlkL1YwEOqiMx/TjJjZnqp3gl8z/kMqRY80BiQlyJgSttFTNrTMaL7si2rqj8HixEz4yYHVZRGz9/jaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469418; c=relaxed/simple;
	bh=JFcq7Ees0f1A9XHuYLwHZ7ylHhZ60RDjWM9BLLmHbiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yqnmj+w2pzaZ0qvSEQHAiTAIcGdXmsCfrsfJ212O684IpQsmFn/iUeylqtq0hrDEdePzCDqrMFd6tfyOGwYsmlR13xL+zzoRgGJ5fdAYqplJ/F80P7tdsToKocwi737z9ygLFeIFC1fgN92u0DQ/FsyCZWuN4+C9ddKTheF001k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDrtm9jP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF3EC4CECC;
	Wed,  9 Oct 2024 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469418;
	bh=JFcq7Ees0f1A9XHuYLwHZ7ylHhZ60RDjWM9BLLmHbiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vDrtm9jP2OJhm+Ta7mB0SpvJNHHh91XusZyAMoFrw2wFdmjKk0r1FL5qEAxTWYr7+
	 lpKEAWzF0sndJmw3gMdKRMpC7pC+HQt/C3WUaUF5FruOxKTxXyl6ejWd/ayPziKdVf
	 wLJxoeViQhQhoNa2Z1KrukEHsQ+y5mHTI23shi7fzofYMLoNn+6LpUEsVbEP6OBdWT
	 3oZ7bm5IWZcSEedesUt5SS/HJLAlblmDFycDdfQbYgXbK76uKZs01eRfOryc8sBbQ4
	 kaTFY9jflPwxeSeSkympXhzH0fg9rxd7r27K/aypqwWXgWAlzgnBBmGsU+i2tCf6Vz
	 tRrW4LvDXQiwg==
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240924-mfd-bd96801-maple-v1-1-04fe33e1f009@kernel.org>
References: <20240924-mfd-bd96801-maple-v1-1-04fe33e1f009@kernel.org>
Subject: Re: (subset) [PATCH] mfd: bd96801: Use maple tree register cache
Message-Id: <172846941709.482065.1633992845676529368.b4-ty@kernel.org>
Date: Wed, 09 Oct 2024 11:23:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 24 Sep 2024 18:22:04 +0200, Mark Brown wrote:
> The maple tree register cache uses a more modern data structure than the
> rbtree cache and makes implementation decisions more suited to modern
> hardware, switch the bd96801 driver to it to take advantage of this newer
> code. No functional changes.
> 
> 

Applied, thanks!

[1/1] mfd: bd96801: Use maple tree register cache
      commit: f8e7a05154d0fe3e977e1cbfdc43657cebd560ef

--
Lee Jones [李琼斯]


