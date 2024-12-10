Return-Path: <linux-kernel+bounces-439116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3439EAAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0967A2818C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424202309AA;
	Tue, 10 Dec 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hisit47a"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D623098B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820465; cv=none; b=rDhqpkkE01lMdV6yHo55QY/9riTD3XuZIPYpgutIrfdJobE+SBaFVyku9kA412DML6iH9N+MxP04FFgZuUqpQj6X+AiQTp7/OlbNvcSNCm50Qv5okGEbVHZzhGRhxa1JAmGGCvEpIx/RyPV51LWgeggqCHYotpnPxrYhTcmnbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820465; c=relaxed/simple;
	bh=ECuAT4nP7i9BweFK7juZ/y9yq7LiAJKWQ8pjhyaZfU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RkShLhVlUVZPGJrYRSj5hkBfTWyRcLAURaCRjZ+lpMrjBE1JDkXYTlzRZfjPbPdMBXhQnMTKPB2ImpGFUVkdQStKk4o8G/A6bIfFVRT3XMAdk3vJT4140kfPZK/HydEfaz8GMDinYNcCfyj+vS+h7IehNv9xBj4oQi2Jklkgwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hisit47a; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso2429540f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733820461; x=1734425261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LN3mYjDf0WLLoooPbhO+3Eb4XaEvDNDr4DXqom+zuiQ=;
        b=hisit47ayBdrn6NOlOd/osOhMZOh2Vwdj0N88+i8JsaSJrNutoZTZzsQF0b3jxBSNo
         cFhYI3Rh0TDuYZV3oAsUNlFBQ/U5d8wWBSzw4J8ezp7trY40SEE9U5U6+fUUbyFsWvLn
         FQ1SZpCS1ckGz/4OTuxaFMd8tWaxZVkv9nD8OtXMQmij3l7Wfj0MvuFPgsTeHbLvE7L1
         RxOsf0VgtMRBT7astiblLbToS+2jg79po1CaiGR5mw78TB5AReHhqg+XezCrcTksvUe9
         l8qBB37nP9bbGGkgbcAh2m9oc4M6qm/+sMvf6ouJfoFBcM6nibWgXld9XwoFLaUTnx1V
         Wy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820461; x=1734425261;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LN3mYjDf0WLLoooPbhO+3Eb4XaEvDNDr4DXqom+zuiQ=;
        b=wbp62YKM79r4xoJ45rqltgytu5UxnfV3TFvaeUYNQ5G6Fn+Y6w92UbltdEItOnin4C
         M1wasr1QtFmoIOjf62Ef/OKm7q3v9gNJ8SMT4Z4ewoUIT2zUROBhBy46N3q5YE/CTbMT
         QHDyQV9abdzHQsPX0MCFvHbXk5Izbl5DKB14d6KACLxkfTqJyx9CPn8e2DCFP3Hwh4Fj
         6PYhOdia73hHirjk2cCZvn76xd6WX/vSlvYbSAqjDey5H4lO8+bwpNgd/VyZffVKVZ0L
         GDrLTL6YPmNoA3h3b/RzxwMT9/wm8K1Zt6ZUtK4/lVWrCmtSiu1FPC5+I+mh5hug9c41
         mXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdwBmuOxS75ochynv47aT1+KBVrtHkh7ZkIgUu50FM5jgCqRUeaTbwBqk/zkDUkhN9m/vkdppO7LMSy4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1gtkoSujcxXtU7l3ROYjrQAcmON1/jBv9rameGsb4NzwLnpZc
	ixEo0LQH+Fuu4y/PsBRSucYiMUIXJhyBB1peFL4vczuGi31OOi+ZathRkiYnZ+4=
X-Gm-Gg: ASbGnctwYJ5sNr5s9eQZ+bfU8zQxf3dMtpfNX673R8CiM8Rm2Y8tOqeVS24bkGMD/Tp
	IeaEN1jkgRwvDr/0DtWHo0JoEq3qOe+wVkhU98UCcQq3XTLgxNGNe6rHxZih+WTZNHDlwp/7QC+
	36uJPoTkDJ2e/3GoFlmpPF++8mh+Dmgpp808VF6oUYksxgxBzHs6oPUp2sBQTSjUnR6Fz9qZw9J
	EK2/+jbKGJHs6WuKOHjsZ5idP+R5ws9o0iHv6ehsIBhvbEImVNv3FpcnlQ=
X-Google-Smtp-Source: AGHT+IG5cwePAttfHDiwnbYJqi1bg7G1KUe+FWSYgo/LN7Cys+F7UYQC66MSd4jFa0z12FH5wxvVww==
X-Received: by 2002:a5d:47c9:0:b0:386:3328:6106 with SMTP id ffacd0b85a97d-386453e5101mr2651418f8f.35.1733820460851;
        Tue, 10 Dec 2024 00:47:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a859esm15209515f8f.23.2024.12.10.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:47:40 -0800 (PST)
Date: Tue, 10 Dec 2024 11:47:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Lothar Rubusch <l.rubusch@gmail.com>,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: Re: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark
 events
Message-ID: <dc914326-7eae-4e4a-8c93-ae1a7007bcc9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205171343.308963-11-l.rubusch@gmail.com>

Hi Lothar,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lothar-Rubusch/iio-accel-adxl345-refrase-comment-on-probe/20241206-011802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241205171343.308963-11-l.rubusch%40gmail.com
patch subject: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark events
config: nios2-randconfig-r072-20241210 (https://download.01.org/0day-ci/archive/20241210/202412101132.Kj6R6i3h-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412101132.Kj6R6i3h-lkp@intel.com/

smatch warnings:
drivers/iio/accel/adxl345_core.c:441 adxl345_event_handler() warn: unsigned 'int_stat' is never less than zero.

vim +/ret +321 drivers/iio/accel/adxl345_core.c

55d2386488598bb Lothar Rubusch 2024-12-05  433  static irqreturn_t adxl345_event_handler(int irq, void *p)
55d2386488598bb Lothar Rubusch 2024-12-05  434  {
55d2386488598bb Lothar Rubusch 2024-12-05  435  	struct iio_dev *indio_dev = p;
55d2386488598bb Lothar Rubusch 2024-12-05  436  	struct adxl345_state *st = iio_priv(indio_dev);
55d2386488598bb Lothar Rubusch 2024-12-05  437  	u8 int_stat;
                                                        ^^^^^^^^^^^

55d2386488598bb Lothar Rubusch 2024-12-05  438  	int samples;
55d2386488598bb Lothar Rubusch 2024-12-05  439  
55d2386488598bb Lothar Rubusch 2024-12-05  440  	int_stat = adxl345_get_status(st);
55d2386488598bb Lothar Rubusch 2024-12-05 @441  	if (int_stat < 0)
                                                            ^^^^^^^^^^^^
signedness bug

55d2386488598bb Lothar Rubusch 2024-12-05  442  		return IRQ_NONE;
55d2386488598bb Lothar Rubusch 2024-12-05  443  
55d2386488598bb Lothar Rubusch 2024-12-05  444  	if (int_stat == 0x0)
55d2386488598bb Lothar Rubusch 2024-12-05  445  		goto err;
55d2386488598bb Lothar Rubusch 2024-12-05  446  
55d2386488598bb Lothar Rubusch 2024-12-05  447  	if (int_stat & ADXL345_INT_OVERRUN)
55d2386488598bb Lothar Rubusch 2024-12-05  448  		goto err;
55d2386488598bb Lothar Rubusch 2024-12-05  449  
55d2386488598bb Lothar Rubusch 2024-12-05  450  	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
55d2386488598bb Lothar Rubusch 2024-12-05  451  		samples = adxl345_get_samples(st);
55d2386488598bb Lothar Rubusch 2024-12-05  452  		if (samples < 0)
55d2386488598bb Lothar Rubusch 2024-12-05  453  			goto err;
55d2386488598bb Lothar Rubusch 2024-12-05  454  
55d2386488598bb Lothar Rubusch 2024-12-05  455  		if (adxl345_fifo_push(indio_dev, samples) < 0)
55d2386488598bb Lothar Rubusch 2024-12-05  456  			goto err;
55d2386488598bb Lothar Rubusch 2024-12-05  457  
55d2386488598bb Lothar Rubusch 2024-12-05  458  	}
55d2386488598bb Lothar Rubusch 2024-12-05  459  	return IRQ_HANDLED;
55d2386488598bb Lothar Rubusch 2024-12-05  460  
55d2386488598bb Lothar Rubusch 2024-12-05  461  err:
55d2386488598bb Lothar Rubusch 2024-12-05  462  	adxl345_fifo_reset(st);
55d2386488598bb Lothar Rubusch 2024-12-05  463  
55d2386488598bb Lothar Rubusch 2024-12-05  464  	return IRQ_HANDLED;
55d2386488598bb Lothar Rubusch 2024-12-05  465  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


