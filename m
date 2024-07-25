Return-Path: <linux-kernel+bounces-261947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED5993BE27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63958284363
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD7194A4F;
	Thu, 25 Jul 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZxFmSuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614F1946C7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897236; cv=none; b=P6w7v7OeuZkkzc3xOOE5vh95zOg0h5lUZWiegBbyjhGO/ueLaAUo7ENVCqt5Utn21wFjEdPM+qU33iJgxdDkxMWmKTp/hIqCnCJHgNZGt3gRWq0i2o6qYtgQgzNlT7VeqrGqRLfbpOBCbVrB03areNFLQaIR/GeB/6xnFn64jZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897236; c=relaxed/simple;
	bh=jWeLg4NEFqM5A/2exOonRfbdbTg1QeRP3dBmSMSHTvY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PNWhlmTBmhBOEqMo0VV7nmCKmdoOzjfAMHbwMhuL0m/Fo0qBFnScnakHg8oONGLYb3arF8TfSu6CzgvEwtVyX4KvICAAQDZR3wPN6u1d1iuUprjRZ7L25qfUKXjVOTmDDM4MWmNrCDJOAVD6preITKQiO8WDT3aAUpKWGl1q7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZxFmSuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23FEC116B1;
	Thu, 25 Jul 2024 08:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721897236;
	bh=jWeLg4NEFqM5A/2exOonRfbdbTg1QeRP3dBmSMSHTvY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LZxFmSuyWwo77iqLSUAHWgkDaQLrkqggSzlcwAb6s1nnyiTcl01kDSqG27md6GqEQ
	 aPTtv++QWuzRRoLGiPpGa6zokmdbnneANj2wQXKnENmx8Lb3lIcvXraRCxUv7SXAuq
	 DLWaXqb6eVH8uHBjVODocNIRZHWQc18BB0Qqjhf5bqKh8gkZ+wxPcr24egLhE08du2
	 dE+Vb+YbZfJ+NLHhKDCOLaul0OzPMUZKjSdpoIMqtrApyCWfyEI/qm7TOFhu/FkFKi
	 P8o9xfHRM3pVTCKN1L7TZOvxqUJg5s27N7CkFfDV+Tt5jZCCQum8JdzEUDxMAl8AVd
	 pkk/SS5z6e/pQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, linux-kernel@vger.kernel.org, 
 Chen Ni <nichen@iscas.ac.cn>
In-Reply-To: <20240709031824.585922-1-nichen@iscas.ac.cn>
References: <20240709031824.585922-1-nichen@iscas.ac.cn>
Subject: Re: (subset) [PATCH] mfd: 88pm860x-core: Convert comma to
 semicolon
Message-Id: <172189723539.870386.5136418475008092837.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 09:47:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 09 Jul 2024 11:18:24 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied, thanks!

[1/1] mfd: 88pm860x-core: Convert comma to semicolon
      commit: 16dc53c9d37ddbc5831def98fec8f0e92bc07135

--
Lee Jones [李琼斯]


