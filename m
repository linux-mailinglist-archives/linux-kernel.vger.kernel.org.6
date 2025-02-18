Return-Path: <linux-kernel+bounces-519050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7C3A39770
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496A87A4638
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC9723957F;
	Tue, 18 Feb 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="JRYbGWXN"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB88233D9C;
	Tue, 18 Feb 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871995; cv=none; b=pBumqiDGSLcadz+ASQU+q+7mQgOrQw72I9o59TgbamGTDaICe8HH4SHyNcIapYorHpoYevRk4X7sgwb9G09fzkBkAkB7URm62/RImWN/lin2VnNQXe/pdLurJQLcm7Jn1RcCxAAU190v7SXy0qYxC9ngyfkEskGDFzww9dPuC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871995; c=relaxed/simple;
	bh=9ADUzIlkRmx6sq0bOKHim7EKMOadjQ/9CTWIOLtvEYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxZFq5lIxMIUW3YHTFt1Q73tlMW6oE7aBMruELmPPE/XnsHjNCTH4pD9XfP5i23+i2PmqJ/PfcMEgUCfMJZZz+nLGX47bX2xkZpAwVc1NKhZwWfrpoi5de6KXGwXpF35UQBqj5onfEXUPtEDZdapXx/N62svej3QcQAaR11H+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=JRYbGWXN; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=onm1rS1mxSV1bJWjghMpBfWA93PUl1xrcbo/qJEavTA=;
	b=JRYbGWXNxNTc3fQD3n1Nod4sZvyt7wZlNtAe/m1AmszDqyjzw8m6DK6d156Y/F
	oxdLYsPezw+v0qyX429aucWeOhcoQjlkk6JCMRarWykIkIA3lniM00lTYm6xgEHl
	osLY2DhfEW0At1JLJOwMdP6kKdxaEHW0IYfsKdjLc2Ny0=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBnKqjhVrRnFZhhCQ--.20238S3;
	Tue, 18 Feb 2025 17:46:11 +0800 (CST)
Date: Tue, 18 Feb 2025 17:46:09 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] arm64: dts: ls1028a-rdb: Add iio-hwmon
 compatibility table
Message-ID: <Z7RW4WK0qYs7Vo9l@dragon>
References: <20250109112457.553169-1-martyn.welch@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109112457.553169-1-martyn.welch@collabora.com>
X-CM-TRANSID:Ms8vCgBnKqjhVrRnFZhhCQ--.20238S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsco2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQ33ZWe0S+AuKwAAsz

On Thu, Jan 09, 2025 at 11:24:57AM +0000, Martyn Welch wrote:
> Add an iio-hwmon map to utilise the iio framework and access power
> information via the hwmon framework at the same time.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

I do not quite understand "compatibility table" in the subject.  Could
you elaborate a bit?

Shawn


