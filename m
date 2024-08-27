Return-Path: <linux-kernel+bounces-303856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399E961619
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761FC1C235F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0701D1F7D;
	Tue, 27 Aug 2024 17:57:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2FC1D1F52
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781453; cv=none; b=mQ4edb8z9pQtmzKZyxaIhpL7kCR/MgoANIz3+e2Wwoeh8MlKbpgYNJv3Ty7muGmqG5InkEWt/t0YzzNuBE4nhtfdk6WPBclrUuSpMsXgGjjwSAK11H/aqI0zEp6JRabq4UDk9XIPNunQ3SYk98wf6jrSAsrsngUq1YsYKinCCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781453; c=relaxed/simple;
	bh=2pbFQEhMR0diQxlTDxKfg8ummGQwF5yE+6u7+SFWDsU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FkplHXYKtepYnwwDlq4OSl9gEfA2qZw6gYpCTJwmLEZku77AALEBDni2P5gq8+YozCIrkYyAxE7HewJ5NDXYpduR8k8MrLj9e5JEnfNUEqJ2Sh3QW90SQqFM0aipStYUvoTJ7tdfwZDr7ASeovd729vIiMQxnPuBnLeGh+3X/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E397FC4AF68;
	Tue, 27 Aug 2024 17:57:31 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B4D9B10604BD; Tue, 27 Aug 2024 19:57:29 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, 
 Yang Ruibin <11162571@vivo.com>
Cc: opensource.kernel@vivo.com
In-Reply-To: <20240827120816.3910198-1-11162571@vivo.com>
References: <20240827120816.3910198-1-11162571@vivo.com>
Subject: Re: [PATCH v2] HSI: omap-ssi: Remove unnecessary
 debugfs_create_dir() error check
Message-Id: <172478144971.379100.10101639367303895621.b4-ty@collabora.com>
Date: Tue, 27 Aug 2024 19:57:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 27 Aug 2024 20:08:16 +0800, Yang Ruibin wrote:
> Remove the debugfs_create_dir() error check. It's safe to pass in error
> pointers to the debugfs API, hence the user isn't supposed to include
> error checking of the return values.
> 
> 

Applied, thanks!

[1/1] HSI: omap-ssi: Remove unnecessary debugfs_create_dir() error check
      commit: c3eddf5e8c30adb6f43fc0b149e88b9feb76f381

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


